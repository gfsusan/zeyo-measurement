//
//  LabelNode.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 28/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import ARKit

class LabelNode: SCNNode {
    var textNode: SCNText = SCNText(string: "SCNText", extrusionDepth: 0.0)

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
