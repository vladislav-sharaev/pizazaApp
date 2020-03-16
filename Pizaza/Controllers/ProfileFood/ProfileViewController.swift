//
//  ProfileViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do {
            print(Auth.auth().currentUser?.uid as Any)

            try Auth.auth().signOut()
            Helper.helper.goToAuthController(navigationController: self.navigationController!)
        } catch let error {
            print("Error here, ", error)
        }
    }
}
