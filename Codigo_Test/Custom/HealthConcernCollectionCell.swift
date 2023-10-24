//
//  HealthConcernCollectionCell.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class healthConcernCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 25
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = #colorLiteral(red: 0.3818516135, green: 0.4732769728, blue: 0.5358233452, alpha: 1)
    }
    
}


