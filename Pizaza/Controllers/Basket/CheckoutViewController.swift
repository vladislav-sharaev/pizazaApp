//
//  CheckoutViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    var myFinalCost: Double!
    
    @IBOutlet weak var fastSegmentedControl: UISegmentedControl!
    @IBOutlet weak var viewForVC: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let speedContentVC = self.storyboard?.instantiateViewController(identifier: "FastViewController") as! FastViewController
        speedContentVC.view.frame = viewForVC.bounds
        self.addChild(speedContentVC)
        viewForVC.addSubview(speedContentVC.view)
        speedContentVC.didMove(toParent: self)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
  
    @IBAction func fastSegmentedControlAction(_ sender: UISegmentedControl) {
        
        if fastSegmentedControl.selectedSegmentIndex == 0 {
            let speedContentVC = self.storyboard?.instantiateViewController(identifier: "FastViewController") as! FastViewController
            speedContentVC.view.frame = viewForVC.bounds
            self.addChild(speedContentVC)
            viewForVC.addSubview(speedContentVC.view)
            speedContentVC.didMove(toParent: self)

        } else {
            let speedContentVC = self.storyboard?.instantiateViewController(identifier: "DateViewController") as! DateViewController
            speedContentVC.view.frame = viewForVC.bounds
            self.addChild(speedContentVC)
            viewForVC.addSubview(speedContentVC.view)
            speedContentVC.didMove(toParent: self)

        }
        
    }
}

