//
//  ClosetVC.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 04/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ClosetVC: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var closetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closetCollectionView.delegate = self

        ZeyoClient.generateRandomClothes() {
            self.closetCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ZeyoClient.getAllClothes {
            DispatchQueue.main.async {
                self.closetCollectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ZeyoClient.clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothCell", for: indexPath) as! ClothCell
        
        let cloth = ZeyoClient.clothes[indexPath.row]
        cell.displayContent(cloth: cloth)
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
