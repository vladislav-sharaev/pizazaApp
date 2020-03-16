//
//  OneProductViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/4/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class OneProductViewController: UIViewController {
    @IBOutlet weak var oneProductCollectionView: UICollectionView!
    
    let cellsCountInARow = 1
    var foodModel = FoodModel()
    var categorieKind: CategorieKind!
    var usableArray: Array<Food>!
    var productCellID = "OneProductCollectionViewCell"
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionview()
    }
    
    func addCollectionview() {
        oneProductCollectionView.dataSource = self
        oneProductCollectionView.delegate = self
        oneProductCollectionView.register(UINib(nibName: "OneProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: productCellID)
        
        oneProductCollectionView.performBatchUpdates(nil) { (result) in
            self.oneProductCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
 
    }
   

}
extension OneProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usableArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! OneProductCollectionViewCell
        var strMinCalories: String
        var strMaxCalories: String?
        
        if categorieKind == .drink {
            strMinCalories = String(usableArray[indexPath.row].minCalories) + " л."
            if usableArray[indexPath.row].maxCalories != nil {
                strMaxCalories = String(usableArray[indexPath.row].maxCalories!) + " л."
            }
        } else {
            strMinCalories = String(usableArray[indexPath.row].minCalories) + " кг."
            if usableArray[indexPath.row].maxCalories != nil {
                strMaxCalories = String(usableArray[indexPath.row].maxCalories!) + " кг."
            }
        }
        
        let cellContentVC = self.storyboard?.instantiateViewController(identifier: "CellProductViewController") as! CellProductViewController
        cellContentVC.view.frame = cell.bounds
        self.addChild(cellContentVC)
        cell.addSubview(cellContentVC.view)
        cellContentVC.didMove(toParent: self)
        
        cellContentVC.categoreiKind = categorieKind
        cellContentVC.oneProductCostLabel.text = usableArray[indexPath.row].getCost()
        cellContentVC.finalCost = usableArray[indexPath.row].costMin
        cellContentVC.costMin = usableArray[indexPath.row].costMin
        cellContentVC.caloriesMin = usableArray[indexPath.row].minCalories
        if usableArray[indexPath.row].costMax != nil && strMaxCalories != nil {
            cellContentVC.costMax = usableArray[indexPath.row].costMax
            cellContentVC.caloriesSegmentedControl.setTitle(strMaxCalories, forSegmentAt: 1)
            cellContentVC.caloriesMax = usableArray[indexPath.row].maxCalories
        } else {
            cellContentVC.caloriesSegmentedControl.setEnabled(false, forSegmentAt: 1)
        }
        cellContentVC.oneProductNameLabel.text = usableArray[indexPath.row].name
        cellContentVC.oneProductIngridientsLabel.text = usableArray[indexPath.row].ingridients
        cellContentVC.caloriesSegmentedControl.setTitle(strMinCalories, forSegmentAt: 0)
        
        if let url = URL(string: usableArray[indexPath.row].url) {
            UrlLoader.shared.downloadImage(url: url) { (data) in
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cellContentVC.oneProductImageView.image = image
                    
                }
                
            }            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = oneProductCollectionView.frame
        let widthCell = frameVC.width / CGFloat(cellsCountInARow)
        let heightCell = frameVC.height / CGFloat(cellsCountInARow)
        
        return CGSize(width: widthCell, height: heightCell)
    }    
}

