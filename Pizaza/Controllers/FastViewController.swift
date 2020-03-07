//
//  FastViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class FastViewController: UIViewController {
    var finalCost: Double!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var telephoneTF: UITextField!
    @IBOutlet weak var roomTF: UITextField!
    @IBOutlet weak var porchTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var commentTV: UITextView!
    
    
    @IBOutlet weak var adressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTFDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        finalCost = BasketService.shared.getFinalCost().rounded(place: 2)
    }
    
    func addTFDelegate() {
        nameTF.delegate = self
        telephoneTF.delegate = self
        roomTF.delegate = self
        porchTF.delegate = self
        floorTF.delegate = self
        codeTF.delegate = self
        commentTV.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first != nil {
            view.endEditing(true)
        }
    }

    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func filterContent(searchText: String, strToFiltr: String) -> String {
        var text = strToFiltr
        text = strToFiltr.filter { searchText.contains($0) }
        return text
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getAdress" {
            let destVC = segue.destination as! MapViewController
            destVC.delegate = self
        }
    }
    
    @IBAction func nameTFEdChanged(_ sender: UITextField) {
        
        let characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM йцукенгшщзхъфывапролджэячсмитьбю"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Введите ваше имя англиским или русским алфавитом.")
        }
        if sender.text!.count > 30 {
            showAlert(title: "Внимание", message: "Введите ваше имя не более, чем в 30 символов.")
            sender.text?.removeLast()
        }
    }
    @IBAction func phoneTFEdChanged(_ sender: UITextField) {
        
        let characters = "1234567890"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Неверный номер телефона.")
        }
        if sender.text!.count > 9 {
            showAlert(title: "Внимание", message: "Неверный номер телефона.")
            sender.text?.removeLast()
        }
    }
    @IBAction func telephoneTFEditDidEnd(_ sender: UITextField) {
        
        if sender.text != "" {
            if sender.text!.count != 9 {
                showAlert(title: "Внимание", message: "Неверный номер телефона.")
                sender.text?.removeAll()
            }
        }
    }
    
    
    @IBAction func roomTFEdChanged(_ sender: UITextField) {
        
        let characters = "1234567890"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Неверный номер квартиры.")
        }
        if sender.text!.count > 4 {
            showAlert(title: "Внимание", message: "Неверный номер квартиры.")
            sender.text?.removeLast()
        }
        
    }
    @IBAction func porchTFEdChanged(_ sender: UITextField) {
        
        let characters = "1234567890/abcde "
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Неверный номер квартиры.")
        }
        if sender.text!.count > 10 {
            showAlert(title: "Внимание", message: "Неверный номер подъезда.")
            sender.text?.removeLast()
        }
    }
    @IBAction func floorTFEdChanged(_ sender: UITextField) {
        
        let characters = "1234567890"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Неверный этаж.")
        }
        if sender.text!.count > 2 {
            showAlert(title: "Внимание", message: "Неверный этаж.")
            sender.text?.removeLast()
        }
    }
    @IBAction func codeTFEdChanged(_ sender: UITextField) {
        
        let characters = "1234567890*+#"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: characters, strToFiltr: text)
        if text != sender.text {
            showAlert(title: "Внимание!", message: "Неверный код домофона.")
        }
        if sender.text!.count > 10 {
            showAlert(title: "Внимание", message: "Неверный код домофона.")
            sender.text?.removeLast()
        }
    }
    
    @IBAction func finishBtnAction(_ sender: UIButton) {
        if nameTF.text == "" || telephoneTF.text == "" || adressLabel.text == "" {
            showAlert(title: "Заказ не выполнен!", message: "Заполните поле имени, телефона и адреса для оформления заказа")
        } else {
            BasketService.shared.array.removeAll()
            if let tabItems = tabBarController?.tabBar.items {
                let tabItem = tabItems[1]
                tabItem.badgeValue = String(BasketService.shared.array.count)
            }
            navigationController?.popToRootViewController(animated: false)
            showAlert(title: "Заказ оформлен", message: "Не стесняйтесь заказать что-нибудь еще :)")
        }
    }
    
    
    
}

extension FastViewController: MapViewControllerDelegate {
    func getAdress(adress: String) {
        adressLabel.text = adress
    }
}

extension FastViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension FastViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        let myText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numbOfChars = myText.count
        return numbOfChars < 150
    }
    
    
}
