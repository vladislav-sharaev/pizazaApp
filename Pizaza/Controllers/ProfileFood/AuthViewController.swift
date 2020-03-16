//
//  AuthViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        upgradeLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                Helper.helper.goToProfileController(navigationController: self.navigationController!, animated: false)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func upgradeLabel() {
       label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
    }
    @IBAction func createAccAction(_ sender: UIButton) {
    }
    @IBAction func createAccWithGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

//extension AuthViewController: GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        
//        if let error = error {
//            print ("Some error", error)
//            return
//        }
//        
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        
//        Auth.auth().signIn(with: credential) { (result, error) in
//            if let error = error {
//                print("Some sign in error ", error)
//                return
//            }
//            guard let uid = result?.user.uid else { return }
//            guard let email	 = result?.user.email else { return }
//            guard let userName = result?.user.displayName else { return }
//            let values = ["email": email, "username": userName]
//            
//            Database.database().reference().child(uid).updateChildValues(values) { (error, ref) in
//                
//            }
//
//        }
//        
//    }
//    
//    
//}
