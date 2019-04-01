//
//  MeasureManager.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 27/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

class MeasureManager {
    let category: Category
    
    let bodyParts: [Part]
    var currentPart: Part
    
    var state: MeasuringState
    var measurements: [Part : MeasurementAnchor] = [:]
    
    init(category: Category) {
        self.category = category
        
        switch category {
        case .top:
            bodyParts = [.neck, .shoulder, .armhole, .sleeveLength, .sleeveWidth, .length, .done]
        case .bottom:
            bodyParts = [.waist, .hip, .thigh, .hem, .length, .done]
        }
        
        self.currentPart = bodyParts.first!
        
        self.state = .initialized
    }
    
    func switchMode(to mode: MeasuringState, measuring part: Part) {
        guard bodyParts.contains(part) else {
            fatalError("Attempted to switch to an invalid part.")
        }
        
        // Set mode
        self.state = mode
        
        // Set part
        self.currentPart = part
    }
    
    func nextPart() -> Part? {
        // 현재 Part가 마지막이면 nil 반환
        if currentPart == bodyParts.last! {
            return nil
        } else {    // 다음 Part가 있으면 해당 Part 반환
            let index = bodyParts.index(of: currentPart)! + 1
            return bodyParts[index]
        }
    }
    
    func previousPart() -> Part? {
        if currentPart == bodyParts.first! {
            return nil
        } else {
            let index = bodyParts.index(of: currentPart)! - 1
            return bodyParts[index]
        }
    }
    
    func removeCurrentMeasurement() {
        measurements.removeValue(forKey: currentPart)
    }
    
    func currentMeasurementAnchor() -> MeasurementAnchor? {
        return measurements[currentPart]
    }
    
    func addMeasurementAnchor(_ anchor: MeasurementAnchor) {
        measurements[currentPart] = anchor
    }
    
    func bitMask() -> Int {
        return currentPart.categoryBitMask
    }
}
