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
    private var _length: Float?
    var length: Float {
        get {
            let unit = ApplicationSettings.Status.defaultUnit
            return _length ?? 0 * unit.factor
        }
        
        set (value) {
            _length = value
        }
    }
    var lengthLabel: String {
        get {
            let unit = ApplicationSettings.Status.defaultUnit
            return "\(length) \(unit.label)"
        }
    }
    
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
        self._length = position1.distance(from: position2)
        
        return self.lineNode!
    }
    
    func updateLine(fromUpdatingNode: SCNNode) -> LineNode {
     
        return self.lineNode!
    }
    
    func lengthIn(unit: Unit) -> Float? {
        guard let l = _length else { return nil }
        let unit = ApplicationSettings.Status.defaultUnit
        return l * unit.factor
    }
}
