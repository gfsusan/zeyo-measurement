//
//  ClothCell.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 04/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ClothCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func displayContent(cloth: Cloth) {
        thumbImageView.image = cloth.thumbImage
        nameLabel.text = cloth.name
    }
}
