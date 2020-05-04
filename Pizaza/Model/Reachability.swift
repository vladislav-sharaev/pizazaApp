//
//  Reachability.swift
//  Pizaza
//
//  Created by Vladimir Sharaev on 29.04.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {return false}
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    class func nonConnection(otherVC: UIViewController) {
        print("here")
        let sb = UIStoryboard(name: "ProfileFood", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ReachabilityViewController") as! ReachabilityViewController
        vc.modalPresentationStyle = .fullScreen
        otherVC.present(vc, animated: true, completion: nil)
    }
}
