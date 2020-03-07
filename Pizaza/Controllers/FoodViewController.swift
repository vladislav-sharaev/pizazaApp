//
//  FoodViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/3/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    var categorieKind: CategorieKind! = nil
    let foodCellID = "FoodCollectionViewCell"
    let foodModel = FoodModel()
    var usableArray = Array<Food>()
    let cellsCountInARow = 2
    let offSet: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        usableArray = chooseKind(categorieKind: categorieKind)
        
    }
    
    func addCollectionView() {
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        foodCollectionView.register(UINib(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: foodCellID)
    }
    
    func chooseKind(categorieKind: CategorieKind) -> Array<Food> {
        switch categorieKind {
        case .pizza:
            title = categorieKind.title
            return foodModel.pizzaContainer
        case .drink:
            title = categorieKind.title
            return foodModel.drinkContainer
        case .candy:
            title = categorieKind.title
            return foodModel.candyContainer
        }
    }
    
}

extension FoodViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usableArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellID, for: indexPath) as! FoodCollectionViewCell
        
        if let url = URL(string: usableArray[indexPath.row].url) {
            UrlLoader.shared.downloadImage(url: url) { (data) in
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.foodImageVIew.image = image
                }
            }
        }
        if categorieKind == .drink {
            cell.caloriesLabel.text = String(usableArray[indexPath.row].minCalories) + " л."
        } else {
            cell.caloriesLabel.text = String(usableArray[indexPath.row].minCalories) + " кг."

        }
        cell.foodNameLabel.text = usableArray[indexPath.row].name
        cell.ingridientsLabel.text = usableArray[indexPath.row].ingridients
        cell.costLabel.text = usableArray[indexPath.row].getCost()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(cellsCountInARow)
        let heightCell = widthCell * 1.9
        let spacing = CGFloat(cellsCountInARow + 1) * offSet / CGFloat(cellsCountInARow)
        
        return CGSize(width: widthCell - spacing, height: heightCell - (2 * offSet))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "OneProductViewController") as! OneProductViewController
        vc.indexPath = indexPath
        vc.usableArray = usableArray
        vc.categorieKind = categorieKind
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
