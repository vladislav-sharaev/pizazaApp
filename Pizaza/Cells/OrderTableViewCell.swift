//
//  OrderTableViewCell.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
