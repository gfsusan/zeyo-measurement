//
//  Extensions.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 22/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import ARKit

extension SCNVector3: Equatable {
    static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
    func distance(from vector: SCNVector3) -> Float {
        let distanceX = self.x - vector.x
        let distanceY = self.y - vector.y
        let distanceZ = self.z - vector.z
        
        return sqrtf( (distanceX * distanceX) + (distanceY * distanceY) + (distanceZ * distanceZ))
    }
    
    public static func ==(lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z)
    }
}

extension SCNNode {
    func setSelected() {
        self.geometry?.firstMaterial?.transparency = 0.5
        self.scale(byX: 2.0, y: 2.0, z: 3.0)
        
        let centerShape = SCNSphere(radius: 0.001)
        let centerNode = SCNNode(geometry: centerShape)
        centerNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.addChildNode(centerNode)
    }
    
    func scale(byX x: Float, y: Float, z: Float) {
        let originalScale = self.scale
        let scaleVector = SCNVector3Make(originalScale.x * 2,
                                         originalScale.y * 2,
                                         originalScale.z * 2)
        self.scale = scaleVector
    }
}

extension ARAnchor {
    func position() -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
}

extension ARSCNView {
    func realWorldVector(screenPos: CGPoint) -> SCNVector3? {
        let planeTestResults = self.hitTest(screenPos, types: [.featurePoint])
        if let result = planeTestResults.first {
            return SCNVector3.positionFromTransform(result.worldTransform)
        }
        
        return nil
    }
}
