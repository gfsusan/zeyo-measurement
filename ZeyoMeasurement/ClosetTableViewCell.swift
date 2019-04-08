//
//  ClosetTableViewCell.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 08/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ClosetTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var category: Category = .top {
        didSet {
            clothes = ZeyoClient.clothes.filter({ (cloth) -> Bool in
                return cloth.category == category
            })
        }
    }
    var clothes: [Cloth]! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothCell", for: indexPath) as? ClothCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let cloth = clothes[indexPath.row]
        cell.displayContent(cloth: cloth)
                
        return cell
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
