//
//  Cloth.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 04/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import UIKit

class Cloth {
    static var ctr = 1
    
    var name: String
    var category: Category
    var parts: [Part]
    var measurements: [Part :  Float]
    var thumbImage: UIImage?
    
    init(name: String, manager: MeasureManager) {
        self.name = name
        self.category = manager.category
        self.parts = manager.bodyParts
        self.measurements = manager.measurements.mapValues({ (measurement) -> Float in
            return measurement.length
        })
        self.thumbImage = manager.thumbImage
    }
    
    init(name: String, category: Category, parts: [Part], measurements: [Part : Float], thumbImage: UIImage?) {
        self.name = name
        self.category = category
        self.parts = parts
        self.measurements = measurements
        self.thumbImage = thumbImage
    }
    
    init(random: Bool) {
        self.name = "옷\(Cloth.ctr)"
        Cloth.ctr = Cloth.ctr + 1
        self.category = Category.random()
        self.parts = self.category.parts
        measurements = [:]
        for part in parts {
            measurements[part] = Float.random(in: 300.0 ... 600.0) / 10.0
        }
        
        var imageName: String
        switch category {
        case .top:
            imageName = "t"
        case .bottom:
            imageName = "b"
        }
        
        let imageNumber = Int.random(in: 1...8)
        
        self.thumbImage = UIImage(named: "\(imageName)\(imageNumber).jpeg")
    }

    static func generateCloth() -> Cloth {
        return Cloth(random: true)
    }
}
