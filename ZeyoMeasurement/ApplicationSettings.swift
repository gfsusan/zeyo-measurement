//
//  ApplicationSettings.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 02/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ApplicationSettings {
    struct Config {
        static let defaultUnit = "com.suzenyada.defaultUnit"
    }
    
    struct Status {
        static var defaultUnit: Unit = {
            guard let str = UserDefaults.standard.string(forKey: Config.defaultUnit) else {
                return Unit.centimeter
            }
            return Unit(rawValue: str) ?? Unit.centimeter
        }() {
            didSet {
                UserDefaults.standard.setValue(defaultUnit.rawValue, forKey: Config.defaultUnit)
            }
        }
    }
}
