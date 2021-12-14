//
//  ViewControllerExtension.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 19/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import UIKit

extension ARMeasureVC {
    func switchUnit(to unit: Unit) {
        self.currentUnit = unit
    }
    
    /**
     Setup for mode.
     */
    func switchMode(to mode: MeasuringState, measuring part: Part) {
        manager.switchMode(to: mode, measuring: part)
        
        switch (mode) {
        case .initialized:
            // uncomment to clear all nodes when switching parts
            // self.clearSceneView()
            
            if part == .done {
                self.currentMeasurementAnchor = nil
            }
            else if let currentMeasurement = manager.currentMeasurementAnchor() {
                print("restored saved anchors")
                self.currentMeasurementAnchor = currentMeasurement
                
                // load anchors
                guard let firstAnchor = currentMeasurement.firstAnchor,
                    let secondAnchor = currentMeasurement.secondAnchor else { return }
                
                self.sceneView.session.add(anchor: firstAnchor)
                self.sceneView.session.add(anchor: secondAnchor)
                
                // set mode to finished since two anchors are loaded
                manager.switchMode(to: .finished, measuring: part)
            } else {
                self.currentMeasurementAnchor = MeasurementAnchor()
            }
            
        default:
            // do nothing
            break;
        }
        
        // update UI to match current state
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    /**
     Update the UI based on current state
     */
    func updateUI() {
        let loadpage  = LoadPage.init()

        self.setInstructionLabel()
        
        
        if let _ = manager.previousPart() {
            if manager.state == .started {
                loadpage.previousButton.isEnabled = false
            } else {
                loadpage.previousButton.isEnabled = true
            }
        } else {
            loadpage.previousButton.isEnabled = false
        }
        
        if let currentMeasurement = currentMeasurementAnchor {
            if let _ = currentMeasurement.firstAnchor, let _ = currentMeasurement.secondAnchor {
                loadpage.createPointButton.isEnabled = false
                loadpage.nextButton.isEnabled = true
            } else {
                loadpage.createPointButton.isEnabled = true
                loadpage.nextButton.isEnabled = false
            }
            
            if let _ = currentMeasurement.firstAnchor {
                UIView.animate(withDuration: 0.5) {
                    loadpage.resetButton.alpha = 1.0
                    loadpage.resetButton.isHidden = false
                }
            } else {
                loadpage.resetButton.alpha = 0.0
                loadpage.resetButton.isHidden = true
            }
        }
        
        // call sequence must be maintained
        loadpage.aimView.isHidden = !loadpage.createPointButton.isEnabled
        
        if manager.currentPart == .done {
            loadpage.nextButton.isEnabled = false
            loadpage.createPointButton.isEnabled = true
            loadpage.createPointButton.setTitle("촬영", for: .normal)
            loadpage.createPointButton.removeTarget(self, action: #selector(createPoint), for: .touchUpInside)
            loadpage.createPointButton.addTarget(self, action: #selector(finishMeasurement), for: .touchUpInside)
        } else {
            loadpage.createPointButton.setTitle("점 찍기", for: .normal)
            loadpage.createPointButton.removeTarget(self, action: #selector(finishMeasurement), for: .touchUpInside)
            loadpage.createPointButton.addTarget(self, action: #selector(createPoint), for: .touchUpInside)
        }
        loadpage.instructionView.setNeedsLayout()
        loadpage.instructionView.layoutIfNeeded()
    }
    
    /**
     Remove all anchors and nodes regarding currentMeasurement, if available
     */
    func clearSceneView() {
        guard let currentMeasurement = self.currentMeasurementAnchor else { return }
        
        if let anchor = currentMeasurement.firstAnchor {
            sceneView.session.remove(anchor: anchor)
        }
        
        if let anchor = currentMeasurement.secondAnchor
        {
            sceneView.session.remove(anchor: anchor)
        }
        
        if let line = currentMeasurement.lineNode {
            line.removeFromParentNode()
        }
        
        if let text = currentMeasurement.textNode {
            text.removeFromParentNode()
        }
    }
    
    func setInstructionLabel() {
        let loadpage  = LoadPage.init()

        //instructionView.alpha = 0.0

        // Show the body part that the user is measuring in a UILabel
        if manager.currentPart == .done {
            // 다끝났을 ~~ 때 ~~~~
            var labelText = "측정 결과"
            for (part, measurement) in manager.measurements {
                labelText += "\n\(part.label): "
                labelText += measurement.lengthLabel
            }
            loadpage.instructionText = labelText
            
        } else {
            switch (manager.state) {
            case .initialized:
                 loadpage.instructionText = "\(manager.currentPart.label) 길이의 시작점을 찍어주세요."
            case .started:
                loadpage.instructionText = "\(manager.currentPart.label) 길이의 끝점을 찍어주세요."
            case .finished:
                if let currentMeasurement = currentMeasurementAnchor {
                            loadpage.instructionText = "\(currentMeasurement.lengthLabel)\n"
                                        + "양 끝의 동그라미를 꾹 누르면 수정할 수 있습니다"
                }
            }
        }
        
        //instructionLabel.sizeToFit()
        
        UIView.animate(withDuration: 0.5) {
            loadpage.instructionView.alpha = 1.0
        }
        
    }
    
    func showAimImage() {
        let loadpage  = LoadPage.init()
        loadpage.aimView.isHidden = false
    }
    
    func hideAimImage() {
        let loadpage  = LoadPage.init()
        loadpage.aimView.isHidden = true
    }
    
    func setupGestureRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.sceneView.addGestureRecognizer(longPressRecognizer)
        
    }
    
//    func removeGestureRecognizer() {
//        DispatchQueue.main.async {
//            self.sceneView.removeGestureRecognizer(self.longPressRecognizer)
//        }
//    }
}
