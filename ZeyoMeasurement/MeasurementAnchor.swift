//
//  MeasurementNode.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 20/03/2019.
//  Copyright © 2019 Droids On Roids. All rights reserved.
//

import Foundation
import UIKit
import ARKit

class MeasurementAnchor {
    var firstAnchor: ARAnchor?
    var secondAnchor: ARAnchor?
    
    var lineNode: LineNode?
    private var length: Float?
    
    var text: SCNText?
    var textNode: SCNNode?
    
    init() {
        
    }
    
    /**
     Updates line and length
    */
    func updateLine() -> LineNode? {
        guard let anchor1 = firstAnchor, let anchor2 = secondAnchor else { return nil}
        let position1 = anchor1.position()
        let position2 = anchor2.position()
        
        self.lineNode = LineNode(startVector: position1, endVector: position2)
        self.length = position1.distance(from: position2)
        
        return self.lineNode!
    }
    
    func updateLine(fromUpdatingNode: SCNNode) -> LineNode {
     
        return self.lineNode!
    }
    
    func lengthIn(unit: Unit) -> Float? {
        guard let l = length else { return nil }
        return l * unit.factor
    }
    
    func setLength(_ length: Float) {
        self.length = length
        
    }
}
