//
//  Modes.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 19/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

class ModeManager {
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
            bodyParts = [.waist, .hip, .허벅지둘레, .밑단, .length, .done]
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
}

enum Category: Int {
    case top
    case bottom
}

enum Part: Int {
    case neck
    case shoulder
    case armhole
    case sleeveLength
    case sleeveWidth
    case waist
    case hip
    case 허벅지둘레
    case 밑단
    case length
    case done
    
    var label: String {
        switch self {
        case .neck:
            return "목 단면"
        case .shoulder:
            return "어깨"
        case .armhole:
            return "암홀"
        case .sleeveLength:
            return "소매"
        case .sleeveWidth:
            return "소매통"
        case .length:
            return "총장"
        case .waist:
            return "허리 단면"
        case .hip:
            return "엉덩이 단면"
        case .허벅지둘레:
            return "허벅지 단면"
        case .밑단:
            return "밑단"
        case .done:
            return "측정이 완료되었습니다."
        }
    }
}

enum MeasuringState {
    // Initialized. No anchors added.
    case initialized
    // First(starting) anchor added. Add last(ending) anchor.
    case started
    // First and last anchor added. Remove all anchors.
    case finished
}

enum Unit {
    case meter
    case centimeter
    case inch
    
    var label: String {
        switch self {
        case .meter:
            return "m"
        case .centimeter:
            return "cm"
        case .inch:
            return "in"
        }
    }
    
    var factor: Float {
        switch  self {
        case .meter:
            return 1.0
        case .centimeter:
            return 100.0
        case .inch:
            return 39.3701
            
        }
    }
}
