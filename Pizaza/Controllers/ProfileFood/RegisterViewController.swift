//
//  RegisterViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        addTFDelegate()
        
    }
    
    func addTFDelegate() {
        nameTF.delegate = self
        loginTF.delegate = self
        passTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first != nil {
            view.endEditing(true)
        }
    }
    
    func filterContent(searchText: String, strToFiltr: String) -> String {
        var text = strToFiltr
        text = strToFiltr.filter { searchText.contains($0) }
        return text
    }
    @IBAction func nameTFEdEnd(_ sender: UITextField) {
        let characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM йцукенгшщзххъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
        guard let text = sender.text else { return }
        let someText = filterContent(searchText: characters, strToFiltr: text)
        if text != someText {
            errorLabel.isHidden = false
            errorLabel.text = "Введите имя русскими или английскими символами"
        } else { errorLabel.isHidden = true }
        if text.count > 25 || text.count < 3 {
            errorLabel.isHidden = false
            errorLabel.text = "Введите ваше имя, используя от 3 до 25 символов"
        } else { errorLabel.isHidden = true }
    }
    @IBAction func loginTFEdEnd(_ sender: UITextField) {
    }
    @IBAction func passTFEdEnd(_ sender: UITextField) {
        let characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMйцукенгшщзххъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ1234567890"
        guard let text = sender.text else { return }
        let someText = filterContent(searchText: characters, strToFiltr: text)
        if text != someText {
            errorLabel.isHidden = false
            errorLabel.text = "Введите пароль русскими или английскими символами и цифрами"
        } else { errorLabel.isHidden = true }
        if text.count > 25 {
            errorLabel.isHidden = false
            errorLabel.text = "Введите ваш пароль, используя до 25 символов"
        } else { errorLabel.isHidden = true }
    }
    
    func checkValid() -> String? {
        if nameTF.text == "" || passTF.text == "" || loginTF.text == nil {
                errorLabel.isHidden = false
                return "Заполните все поля."
            }
        errorLabel.isHidden = true
        return nil
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        if checkValid() != nil {
            errorLabel.text = checkValid()
        } else if errorLabel.isHidden == true {
            Auth.auth().createUser(withEmail: loginTF.text!, password: passTF.text!) { (result, error) in
                if error != nil {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "\(error!.localizedDescription)"
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "name": self.nameTF.text!, "post": self.loginTF.text!
                    ]) { (error) in
                        if error != nil {
                            fatalError("Eror saving user in db")
                        }
                        
                    }
                    Helper.helper.goToProfileController(navigationController: self.navigationController!, animated: true)
                }
            }
            
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
