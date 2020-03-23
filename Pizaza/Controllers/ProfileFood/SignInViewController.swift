//
//  SignInViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        addTFDelegate()
    }
    
    func addTFDelegate() {
        loginTF.delegate = self
        passTF.delegate = self
    }
    
    @IBAction func loginTFEdEnd(_ sender: UITextField) {
    }
    @IBAction func passTFEdEnd(_ sender: UITextField) {
    }
    @IBAction func signInAction(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: loginTF.text!, password: passTF.text!) { (result, error) in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error!.localizedDescription
            } else {
                let vc = self.storyboard!.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
                
                self.navigationController?.setViewControllers([vc], animated: true)
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
