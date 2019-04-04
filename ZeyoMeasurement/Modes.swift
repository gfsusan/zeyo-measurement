//
//  Modes.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 19/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import UIKit

enum Category: Int {
    case top
    case bottom
    
    var parts: [Part] {
        switch self {
        case .top:
            return [.neck, .shoulder, .armhole, .sleeveLength, .sleeveWidth, .length]
        case .bottom:
            return [.waist, .hip, .thigh, .hem, .length]
        }
    }
}

enum categoryBitMask: Int {
    case cateogoryToSelect = 2
}

enum Part: Int {
    case neck
    case shoulder
    case armhole
    case sleeveLength
    case sleeveWidth
    case waist
    case hip
    case thigh
    case hem
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
        case .thigh:
            return "허벅지 단면"
        case .hem:
            return "밑단"
        case .done:
            return "측정이 완료되었습니다."
        }
    }
    
    var color: UIColor {
        switch self {
        case .neck:
            return UIColor.red
        case .shoulder:
            return UIColor.orange
        case .armhole:
            return UIColor.yellow
        case .sleeveLength:
            return UIColor.green
        case .sleeveWidth:
            return UIColor.blue
        case .waist:
            return UIColor.purple
        case .hip:
            return UIColor.brown
        case .thigh:
            return UIColor.magenta
        case .hem:
            return UIColor.cyan
        case .length:
            return UIColor.planeColor
        case .done:
            return UIColor.black
        }
    }
    
    var categoryBitMask: Int {
        switch self {
        case .neck:
            return 2
        case .shoulder:
            return 4
        case .armhole:
            return 8
        case .sleeveLength:
            return 16
        case .sleeveWidth:
            return 32
        case .waist:
            return 64
        case .hip:
            return 128
        case .thigh:
            return 256
        case .hem:
            return 512
        case .length:
            return 1024
        case .done:
            return 2048
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

enum Unit: String {
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
