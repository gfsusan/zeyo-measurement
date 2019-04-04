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
}
