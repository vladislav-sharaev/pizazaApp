//
//  Helper.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Helper {
    
    var likedFood = [Food]()
    static var helper = Helper()
    static var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    static var environment = "food"
    static var db = Firestore.firestore()
    static var root: CollectionReference {
        return db.collection("users").document(uid!).collection(environment)
    } 
    
//    func goToController(navigationController: UINavigationController, storyboard: UIStoryboard, vc: UIViewController, animated: Bool) {
//        navigationController.setViewControllers([vc], animated: animated)
//    }
        
    func getSnapshotCount() -> Int {
        var count = 0
        Helper.root.getDocuments { (snapshot, error) in
            if let error = error {
                print("Snapshot error ", error)
                return
            }
            count = snapshot!.count
        }
        return count
    }
    
    func addDocToArray(completion: @escaping((Bool) -> ()))  {
        var success = false
        Helper.root.getDocuments { (snapshot, error) in
            if let error = error {
                print("Snapshot error ", error)
                return
            }
            if let documents = snapshot?.documents {
                for document in documents {
                    guard let name = document.data()["name"] as? String else { print ("name error")
                        return}
                    guard let costMin = document.data()["costMin"] as? Double else { print ("costMin error")
                    return}
                    var costMax: Double? = nil
                    if document.data()["costMax"] != nil {
                        costMax = document.data()["costMax"] as? Double
                    }
                    guard let minCalories = document.data()["minCalories"] as? Double else { print ("minCalories error")
                    return}
                    var maxCalories: Double? = nil
                    if document.data()["maxCalories"] != nil {
                        maxCalories = document.data()["maxCalories"] as? Double
                    }
                    var ingridients: String? = nil
                    if document.data()["ingridients"] != nil {
                        ingridients = document.data()["ingridients"] as? String
                    }
                    guard let url = document.data()["url"] as? String else { print ("url error")
                    return}
                    guard let categorie = document.data()["categorieKindText"] as? String else { print ("url error")
                    return}
                    
                    var added = false
                    for element in Helper.helper.likedFood {
                        if element.name == name {
                            added = true
                            
                        }
                    }
                    if added == false {
                        Helper.helper.likedFood.append(Food(name: name, costMin: costMin, costMax: costMax, url: url, minCalories: minCalories, maxCalories: maxCalories, ingridients: ingridients, categorie: categorie ))
                    }
                    success = true
                }
                completion(success)
                //Helper.helper.likedFood.reverse()
            } else {
                print("doc error")
            }

        }
    }
    
    
}
