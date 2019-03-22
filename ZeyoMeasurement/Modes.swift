//
//  Modes.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 19/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

enum BodyPart: Int {
    case neck
    case shoulder
    case armhole
    case sleeveLength
    case sleeveWidth
    case length
    case done
    
    var label: String {
        switch self {
        case .neck:
            return "목둘레"
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
        case .done:
            return "측정이 완료되었습니다."
        }
    }
    
    static var count = 5
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
