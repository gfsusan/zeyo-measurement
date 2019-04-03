//
//  lengthItem.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 03/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

class LengthItem: NSObject {
    var label: String
    var length: Float
    var unit: String
    
    init (label: String, length: Float, unit: String) {
        self.label = label
        self.length = length
        self.unit = unit
    }
}
