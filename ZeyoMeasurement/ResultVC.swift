//
//  ResultVC.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 02/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ResultVC: UITableViewController {
    
    var manager: MeasureManager!
    var measurementList: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measurementList = manager.measurementList
        
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.height
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        print("upload button pressed")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurementList.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170.0
        } else {
            return 44.0
        }
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell
            
            cell?.thumbImage.image = manager.thumbImage
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)
            
            let measurement = measurementList[indexPath.row - 1]
            cell.textLabel?.text = measurement.0
            cell.detailTextLabel?.text = measurement.1
            
            return cell
        }
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
