//
//  Modes.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 19/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

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
