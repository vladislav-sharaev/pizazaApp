//
//  InfoViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {
    
    var infoArray = [Info]()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var porchLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if infoArray[0].date == nil {
            dateLabel.isHidden = true
        } else {
            dateLabel.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            let dateString = formatter.string(from: infoArray[0].date!)
            dateLabel.text! += dateString
        }
        nameLabel.text! += infoArray[0].name!
        telephoneLabel.text! += infoArray[0].telephone!
        adressLabel.text! += infoArray[0].adress!
        roomLabel.text! += infoArray[0].room ?? ""
        porchLabel.text! += infoArray[0].porch ?? ""
        floorLabel.text! += infoArray[0].floor ?? ""
        codeLabel.text! += infoArray[0].code ?? ""
        commentLabel.text! += infoArray[0].comment ?? ""
    }
}
