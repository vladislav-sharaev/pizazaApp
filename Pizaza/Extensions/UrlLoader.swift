//
//  UrlLoader.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/11/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

/*
extension UIImageView {
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
                
            }
            
        }).resume()
        
    }
  
}
 */

class UrlLoader {
    
    static var shared = UrlLoader()    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    func downloadImage(url: URL, completion: @escaping((Data) -> Void)) {
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                            print(httpResponse.statusCode)
                    }
                }
                
            } else {
                print("Error donwload data \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
        
    }
}


