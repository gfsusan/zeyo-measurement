//
//  ClosetVC.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 04/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ClosetVC: UITableViewController {
    
    @IBOutlet weak var closetCollectionView: UICollectionView!
    
    var categories = Category.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ZeyoClient.generateRandomClothes() {
            // do nothing
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Category.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "closetCell", for: indexPath) as? ClosetTableViewCell else {
            return UITableViewCell()
        }
        let category = categories[indexPath.section]
        cell.category = category
        
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
