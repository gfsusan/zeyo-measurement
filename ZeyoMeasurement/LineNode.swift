//
//  LineNode.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 20/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit
import ARKit

class LineNode: SCNNode {
    var startVector: SCNVector3 = SCNVector3()
    var endVector: SCNVector3 = SCNVector3()
    
    override init () {
        super.init()
    }
    
    convenience init(startVector: SCNVector3, endVector: SCNVector3) {
        self.init()
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [startVector, endVector])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        geometry.firstMaterial?.diffuse.contents = UIColor.white
        
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
