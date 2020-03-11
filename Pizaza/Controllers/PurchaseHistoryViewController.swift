//
//  PurchaseHistoryViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/9/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import CoreData

class PurchaseHistoryViewController: UIViewController {
    
    var historyArray = [PurchaseHistory]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()  

    }
    
    func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequestPurch: NSFetchRequest<PurchaseHistory> = PurchaseHistory.fetchRequest()
        do {
            let purchaseHistory = try PersistenceService.context.fetch(fetchRequestPurch)
            self.historyArray = purchaseHistory
            tableView.reloadData()
        } catch {}
    }
}

extension PurchaseHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseHistoryTableViewCell") as! PurchaseHistoryTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        if let date = historyArray[indexPath.row].currentDate {
            let dateString = formatter.string(from: date)
            cell.dateLabel.text = dateString
        }
        cell.finalCostLabel.text = String(historyArray[indexPath.row].finalCost) + " Br."
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let fetchRequestPurch: NSFetchRequest<PurchaseHistory> = PurchaseHistory.fetchRequest()
            do {
                let purchaseHistory = try PersistenceService.context.fetch(fetchRequestPurch)
                PersistenceService.context.delete(purchaseHistory[indexPath.row])
                self.historyArray.remove(at: indexPath.row)
                PersistenceService.saveContext()
                tableView.reloadData()
            } catch {}
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderArray = (historyArray[indexPath.row].order?.allObjects as? [Order])!
        let infoArray = (historyArray[indexPath.row].info?.allObjects as? [Info])!
        let vc = UIStoryboard(name: "PurchaseHistory", bundle: nil).instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        vc.orderArray = orderArray
        vc.infoArray = infoArray
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
