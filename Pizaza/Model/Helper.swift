//
//  Helper.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/15/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Helper {
    
    static var helper = Helper()
    
    func goToProfileController(navigationController: UINavigationController, animated: Bool) {
        
        let storyboard = UIStoryboard(name: "ProfileFood", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        navigationController.pushViewController(vc, animated: animated)
        
    }
    
    func goToAuthController(navigationController: UINavigationController) {        
        navigationController.popToRootViewController(animated: true)
    }
}
