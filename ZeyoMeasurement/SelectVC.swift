//
//  SelectVC.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 25/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class SelectVC: UIViewController {

    let segueIdentifier = "modalARSegue"
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func topPressed(_ sender: Any) {
        self.category = .top
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    @IBAction func bottomPressed(_ sender: Any) {
        self.category = .bottom
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let arVC = segue.destination as? ViewController
        
        if let category = self.category {
            arVC?.manager = MeasureManager(category: category)
        }
    }

}
