//
//  ForgotPassViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 4/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPassViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func changePassAction(_ sender: UIButton) {
        guard let email = emailTF.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error!.localizedDescription
                return
            }
            self.errorLabel.isHidden = true
            self.showAlertWithAction(title: "Операция прошла успешно", message: "Проверьте вашу почту для дальнейшей смены пароля")
        }
    }
    
    func showAlertWithAction(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .cancel, handler: { (alert) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
