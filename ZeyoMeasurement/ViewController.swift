//
//  ViewController.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 22/03/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//
/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Main view controller for the AR experience.
 */

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    // MARK: - IBOutlets
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var createPointButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var instructionView: UIVisualEffectView!
    @IBOutlet weak var instructionLabel: UILabel!
    private var sessionInfoText: String = ""
    
    @IBOutlet weak var aimView: UIImageView!
    
    private let firstName = "firstAnchor"
    private let secondName = "secondAnchor"
    
    var manager: MeasureManager!

    var currentUnit: Unit = .centimeter
    
    var currentMeasurementAnchor: MeasurementAnchor? = MeasurementAnchor()
    var selectedNode: SCNNode?
    
    // MARK: - View Life Cycle
    
    /// - Tag: StartARSession
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Start the view's AR session with a configuration that uses the rear camera,
        // device position and orientation tracking, and plane detection.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
        
        // Set a delegate to track the number of plane anchors for providing UI feedback.
        sceneView.session.delegate = self
        
        // Prevent the screen from being dimmed after a while as users will likely
        // have long periods of interaction without touching the screen or buttons.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Show debug UI to view performance metrics (e.g. frames per second).
//        sceneView.showsStatistics = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupGestureRecognizer()
        switchUnit(to: .centimeter)
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's AR session.
        sceneView.session.pause()
    }
    
    @IBAction func createPointButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (value) in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseIn], animations: {
                sender.transform = CGAffineTransform.identity
            }) { (value) in
            }
        }
        
        guard let currentMeasurement = self.currentMeasurementAnchor else { return }
        
        let touch = CGPoint(x: sceneView.frame.width / 2, y: sceneView.frame.height / 2)
        
        guard let hitTestResult = sceneView.hitTest(touch, types: .existingPlane).first else { return }
        
        if let _ = currentMeasurement.firstAnchor, let _ = currentMeasurement.secondAnchor {
            guard manager.state == .finished else {
                fatalError("Anchor status and mode no not match")
            }
        } else if let _ = currentMeasurement.firstAnchor {
            guard manager.state == .started else {
                fatalError("Anchor status and mode no not match")
            }
            currentMeasurement.secondAnchor = ARAnchor(name: secondName, transform: hitTestResult.worldTransform)
            if let newAnchor = currentMeasurement.secondAnchor {
                self.sceneView.session.add(anchor: newAnchor)
            }
        } else { // if no anchors exist
            guard manager.state == .initialized else {
                fatalError("Anchor status and mode no not match")
            }
            currentMeasurement.firstAnchor = ARAnchor(name: firstName, transform: hitTestResult.worldTransform)
            if let newAnchor = currentMeasurement.firstAnchor {
                self.sceneView.session.add(anchor: newAnchor)
            }
        }
        
        // switch mode in renderer
        

    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        if let previousBodyPart = manager?.previousPart() {
            switchMode(to: .initialized, measuring: previousBodyPart)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if let nextBodyPart = manager?.nextPart() {
            switchMode(to: .initialized, measuring: nextBodyPart)
        } else {
            // all measurements were successfully made
            // proceed to next step
            
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        // this sequence must be maintained
        clearSceneView()
        
        manager.removeCurrentMeasurement()
        switchMode(to: .initialized, measuring: manager.currentPart)        
    }
    
    @objc func longPressed(recognizer: UILongPressGestureRecognizer) {
        guard let recognizerView = recognizer.view as? ARSCNView else { return }
        let touch = recognizer.location(in: recognizerView)
        
        let transform = CGAffineTransform(translationX: 0, y: -50)
        let aboveTouch = touch.applying(transform)
        
        // Keep pressing
        if recognizer.state == .began {
        
            guard manager.currentPart != .done else {
                print("Cannot move node since user has finished measuring.")
                return
            }
            
            let hitTestResult = self.sceneView.hitTest(touch, options: [SCNHitTestOption.categoryBitMask: manager.bitMask()])

            guard let hitNode = hitTestResult.first?.node else { return }
            
            // Set hitNode as selected
            self.selectedNode = hitNode
            
            // change node transparency + aim
            selectedNode?.setSelected()
            
            // Remove line node
            if let currentMeasurement = currentMeasurementAnchor {
                if let oldLine = currentMeasurement.lineNode {
                    oldLine.removeFromParentNode()
                }
            }
            
            
        } else if recognizer.state == .changed {
            
            guard let hitNode = self.selectedNode else { return }
            let hitTestPlane = self.sceneView.hitTest(aboveTouch, types: .existingPlane)
            guard let hitPlane = hitTestPlane.first else { return }
            hitNode.position = SCNVector3(hitPlane.worldTransform.columns.3.x,
                                               hitNode.position.y,
                                               hitPlane.worldTransform.columns.3.z)
            
        // Stopped pressing
        } else if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed{
            
            guard let hitNode = self.selectedNode else { return }
            guard let oldAnchor = sceneView.anchor(for: hitNode) else { return }
            
            hitNode.scale(byX: 0.5, y: 0.5, z: 0.5)
            
            let newAnchor = ARAnchor(name: oldAnchor.name!, transform: hitNode.simdTransform )
            sceneView.session.remove(anchor: oldAnchor)
            sceneView.session.add(anchor: newAnchor)
            print(oldAnchor.transform.columns.3)        // old position
            print(newAnchor.transform.columns.3)        // updated position
            
            if oldAnchor.name! == firstName {
                self.currentMeasurementAnchor?.firstAnchor = newAnchor
            } else if newAnchor.name! == secondName {
                self.currentMeasurementAnchor?.secondAnchor = newAnchor
            }
            
            self.selectedNode = nil
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // Execute the correct code depending on the name of the newly created anchor.
        // Add more if statesments for new models eg. if(anchor.name == "house")...
        var pointNode = SCNNode()
        
        if(anchor.name == firstName || anchor.name == secondName){
            pointNode = createBallNode()
        }
        
        guard let currentMeasurement = self.currentMeasurementAnchor else { return pointNode }
        
        if let _ = currentMeasurement.firstAnchor, let _ = currentMeasurement.secondAnchor {
            if let oldLine = currentMeasurement.lineNode {
                oldLine.removeFromParentNode()
            }
            if let newLine = currentMeasurement.updateLine() {
                sceneView.scene.rootNode.addChildNode(newLine)
            }
            
            manager.addMeasurementAnchor(currentMeasurement)
            
            switchMode(to: .finished, measuring: manager.currentPart)
        } else if let _ = currentMeasurement.firstAnchor {
            switchMode(to: .started, measuring: manager.currentPart)
        }
        
    
        return pointNode
        
    }
    
    func createBallNode() -> SCNNode{
        let ballShape = SCNSphere(radius: 0.01)
        let ballNode = SCNNode(geometry: ballShape)
        ballNode.geometry?.firstMaterial?.diffuse.contents = manager.currentPart.color

        ballNode.categoryBitMask = manager.bitMask()
        
        return ballNode
    }
    
    /// - Tag: PlaceARContent
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Place content only for anchors found by plane detection.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a custom object to visualize the plane geometry and extent.
        let plane = Plane(anchor: planeAnchor, in: sceneView)
        
        // Add the visualization to the ARKit-managed node so that it tracks
        // changes in the plane anchor as plane estimation continues.
        node.addChildNode(plane)
    }
    
    /// - Tag: UpdateARContent
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Update only anchors and nodes set up by `renderer(_:didAdd:for:)`.
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let plane = node.childNodes.first as? Plane
            else { return }
        
        // Update ARSCNPlaneGeometry to the anchor's new estimated shape.
        if let planeGeometry = plane.meshNode.geometry as? ARSCNPlaneGeometry {
            planeGeometry.update(from: planeAnchor.geometry)
        }
        
        // Update extent visualization to the anchor's new bounding rectangle.
        if let extentGeometry = plane.extentNode.geometry as? SCNPlane {
            extentGeometry.width = CGFloat(planeAnchor.extent.x)
            extentGeometry.height = CGFloat(planeAnchor.extent.z)
            plane.extentNode.simdPosition = planeAnchor.center
        }
        
        // Update the plane's classification and the text position
        if let classificationNode = plane.classificationNode,
            let classificationGeometry = classificationNode.geometry as? SCNText {
            let currentClassification = planeAnchor.classification.description
            if let oldClassification = classificationGeometry.string as? String, oldClassification != currentClassification {
                classificationGeometry.string = currentClassification
                classificationNode.centerAlign()
            }
        }
        
    }
    
    // MARK: - ARSessionDelegate
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let frame = session.currentFrame else { return }
        updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        guard let frame = session.currentFrame else { return }
        updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        updateSessionInfoLabel(for: session.currentFrame!, trackingState: camera.trackingState)
    }
    
    // MARK: - ARSessionObserver
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay.
        sessionInfoText = "Session was interrupted"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required.
        sessionInfoText = "Session interruption ended"
        resetTracking()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        sessionInfoText = "Session failed: \(error.localizedDescription)"
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        // Remove optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            // Present an alert informing about the error that has occurred.
            let alertController = UIAlertController(title: "The AR session failed.", message: errorMessage, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
                self.resetTracking()
            }
            alertController.addAction(restartAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private methods
    
    private func updateSessionInfoLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        // Update the UI to provide feedback on the state of the AR experience.
        let message: String
        
        switch trackingState {
        case .normal where frame.anchors.isEmpty:
            // No planes detected; provide instructions for this app's AR interactions.
            message = "Move the device around to detect horizontal and vertical surfaces."
            
        case .notAvailable:
            message = "Tracking unavailable."
            
        case .limited(.excessiveMotion):
            message = "Tracking limited - Move the device more slowly."
            
        case .limited(.insufficientFeatures):
            message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
            
        case .limited(.initializing):
            message = "Initializing AR session."
            
        default:
            // No feedback needed when tracking is normal and planes are visible.
            // (Nor when in unreachable limited-tracking states.)
            message = ""
            
        }
        
        sessionInfoText = message
        
    }
    
    private func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}
