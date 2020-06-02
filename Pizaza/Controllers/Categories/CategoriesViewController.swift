//
//  CategoriesViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var viewsHeight: NSLayoutConstraint!
    @IBOutlet weak var categoriesCollectionVIew: UICollectionView!
    
    let sectionHeaderView = "SectionHeaderViewCollectionReusableView"
    let categoriesCellID = "CategoriesCollectionViewCell"
    let cellsCountInARow = 2
    let offSet: CGFloat = 10
    let categoriesModel = CategoriesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        addCollecetionView()
        if Auth.auth().currentUser != nil {
            print("___________/n Added in categories")
            Helper.helper.addDocToArray { (success) in
            }
        }
    }
    
    func addCollecetionView() {
        
        categoriesCollectionVIew.delegate = self
        categoriesCollectionVIew.dataSource = self
        categoriesCollectionVIew.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: categoriesCellID)
    }

}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCellID, for: indexPath) as! CategoriesCollectionViewCell
        let categorie = categoriesModel.categories[indexPath.row]
        cell.categorieImageView.image = categorie.image
        cell.productNameLabel.text = categorie.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(cellsCountInARow) //1 instead cellCountInRow
        let heightCell = widthCell + 0.5 * widthCell
        let spacing = CGFloat(cellsCountInARow + 1) * offSet / CGFloat(cellsCountInARow)
        
        return CGSize(width: widthCell - spacing, height: heightCell - (2 * offSet))
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let vc = storyboard?.instantiateViewController(identifier: "FoodViewController") as! FoodViewController
        let categorie = categoriesModel.categories[indexPath.row]
        vc.categorieKind = categorie.kind
         //vc.indexPath = indexPath
         self.navigationController?.pushViewController(vc, animated: true)
     }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = categoriesCollectionVIew.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.sectionHeaderView, for: indexPath) as! SectionHeaderViewCollectionReusableView
        return sectionHeaderView
    }
}
