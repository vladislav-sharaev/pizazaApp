//
//  OrderViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIViewController {
    
    var infoArray = [Info]()
    var orderArray = [Order]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    
    func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func goToInfoButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "PurchaseHistory", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        vc.infoArray = infoArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        cell.nameLabel.text = orderArray[indexPath.row].name
        cell.pictureImageView.image = UIImage(data: orderArray[indexPath.row].picture!)
        cell.caloriesLabel.text = String(orderArray[indexPath.row].calories) + " " + orderArray[indexPath.row].caloriesType!
        let finalCost = (orderArray[indexPath.row].cost * Double(orderArray[indexPath.row].count)).rounded(place: 2)
        cell.costLabel.text = "\(orderArray[indexPath.row].cost.rounded(place: 2)) Br. * \(Double(orderArray[indexPath.row].count)) = \(finalCost) Br."
        
        return cell
    }
    
}
