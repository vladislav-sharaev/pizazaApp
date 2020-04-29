//
//  ProfileViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class ProfileViewController: UIViewController {
    
    var categorieKind: CategorieKind! = nil
    var usableArray = Array<Food>()
    let cellsCountInARow = 2
    let offSet: CGFloat = 4
    var count: Int?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        count = Helper.helper.getSnapshotCount()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("______________\n added in profile")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(Auth.auth().currentUser!.uid)
        Helper.helper.addDocToArray { (success) in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
        //self.collectionView.reloadData()
    }
    
    func addCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodCollectionViewCell")
        self.collectionView.reloadData()
    }
    
    @IBAction func updateAction(_ sender: UIBarButtonItem) {
        self.collectionView.reloadData()
    }
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        print(Helper.helper.likedFood.count)

        do {
            print(Auth.auth().currentUser?.uid as Any)
            try Auth.auth().signOut()
            Helper.helper.likedFood.removeAll()
            let vc = self.storyboard!.instantiateViewController(identifier: "AuthViewController") as! AuthViewController
            self.navigationController?.setViewControllers([vc], animated: true)
        } catch let error {
            print("Error here, ", error)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return Helper.helper.addDocToArray()
        return Helper.helper.likedFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        usableArray = Helper.helper.likedFood
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCollectionViewCell", for: indexPath) as! FoodCollectionViewCell
        
        if let url = URL(string: usableArray[indexPath.row].url) {
            UrlLoader.shared.downloadImage(url: url) { (data) in
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.foodImageVIew.image = image
                }
            }
        }
        if usableArray[indexPath.row].categorie == "drink" {
            categorieKind = .drink
            cell.categorieKind = categorieKind
            cell.caloriesLabel.text = String(usableArray[indexPath.row].minCalories) + " л."
        } else if usableArray[indexPath.row].categorie == "pizza" {
            categorieKind = .pizza
            cell.categorieKind = categorieKind
            cell.caloriesLabel.text = String(usableArray[indexPath.row].minCalories) + " кг."
        } else {
            categorieKind = .candy
            cell.categorieKind = categorieKind
            cell.caloriesLabel.text = String(usableArray[indexPath.row].minCalories) + " кг."
        }
         
        cell.food = usableArray[indexPath.row]
        
        cell.foodNameLabel.text = usableArray[indexPath.row].name
        cell.ingridientsLabel.text = usableArray[indexPath.row].ingridients
        cell.costLabel.text = usableArray[indexPath.row].getCost()
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let frameVC = collectionView.frame
           let widthCell = frameVC.width / CGFloat(cellsCountInARow)
           let heightCell = widthCell * 1.9
           let spacing = CGFloat(cellsCountInARow + 1) * offSet / CGFloat(cellsCountInARow)
           
           return CGSize(width: widthCell - spacing, height: heightCell - (2 * offSet))
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let storyboard = UIStoryboard(name: "Categories", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "OneProductViewController") as! OneProductViewController
           vc.indexPath = indexPath
           vc.usableArray = usableArray
           vc.categorieKind = categorieKind
           self.navigationController?.pushViewController(vc, animated: true)
       }
}

extension ProfileViewController: FoodCollectionViewCellDelegate {
    func showNilUser() {
        //
    }
    
    func needUpdate(update: Bool) {
        if update == true {
            self.collectionView.reloadData()
        }
    }
}
