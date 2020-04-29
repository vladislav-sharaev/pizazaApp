//
//  ReachabilityViewController.swift
//  Pizaza
//
//  Created by Vladimir Sharaev on 29.04.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class ReachabilityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshBtn(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() == true {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

func nonConnection(otherVC: UIViewController) {
    print("here")
    let sb = UIStoryboard(name: "ProfileFood", bundle: nil)
    let vc = sb.instantiateViewController(identifier: "ReachabilityViewController") as! ReachabilityViewController
    vc.modalPresentationStyle = .fullScreen
    otherVC.present(vc, animated: true, completion: nil)
}
