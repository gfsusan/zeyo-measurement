//
//  ResultVC.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 02/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ResultVC: UITableViewController {
    
    @IBOutlet weak var footerView: UIView!
    
    var arVC: ARMeasureVC?
    var uploadButton: UIButton?
    
    var closetVC: ClosetVC?
    var editButton: UIBarButtonItem?
    
    var cloth: Cloth?
    var parts: [Part] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ContentCell.self, forCellReuseIdentifier: "contentCell")
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.height
        
        if let _ = arVC {
            print("created upload button")
            uploadButton = makeUploadButton()
        }
        
        if let c = cloth {
            parts = c.category.parts
        }
        
        setupButtonLayouts()
    }
    
    private func setupButtonLayouts() {
        if let upload = uploadButton {
            footerView.addSubview(upload)
            NSLayoutConstraint.activate([
                upload.widthAnchor.constraint(equalToConstant: 88.0),
                upload.heightAnchor.constraint(equalToConstant: 44.0),
                upload.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 8.0),
                upload.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
                ])
        }
    }
    
    private func makeUploadButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appleBlue
        button.layer.cornerRadius = 22
        button.setTitle("업로드", for: .normal)
        button.addTarget(self, action: #selector(uploadPressed), for: .touchUpInside)
        
        return button
    }
    
    @objc func uploadPressed() {
        guard let c = cloth else { return }
        ZeyoClient.postCloth(cloth: c) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300.0
        } else {
            return 44.0
        }
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clothing = cloth else { return UITableViewCell() }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell
            
            cell?.thumbImage.image = cloth?.thumbImage
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentCell
            let part = parts[indexPath.row - 1]
            if let length = clothing.measurements[part] {
                let measurement = (part, length)
                cell.measurementItem = measurement
                
                return cell
            }
        }
        
        return UITableViewCell()
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
