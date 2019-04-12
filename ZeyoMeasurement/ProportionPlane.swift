//
//  ProportionPlane.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 11/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ProportionPlane: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var addPlaneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Plane", for: .normal)
        button.backgroundColor = .appleYellow
        button.layer.cornerRadius = 22
        return button
    }()
    
    var aimView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "aimImage")
        
        return view
    }()
    
    override func viewDidLoad() {
        view.addSubview(addPlaneButton)
        view.addSubview(aimView)
        
        setupLayoutConstraints()
        addPlaneButton.addTarget(self, action: #selector(addPlane), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
        
        sceneView.session.delegate = self
        sceneView.delegate = self
        
        sceneView.debugOptions = [.showFeaturePoints]
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func setupLayoutConstraints() {
        addPlaneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPlaneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        addPlaneButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        addPlaneButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        aimView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aimView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func addPlane() {
        print("Add plane button pressed")
        let hitTest = sceneView.hitTest(aimView.center, types: .existingPlane)
        guard let hitTestResult = hitTest.first else { return }
        
        let anchor = ARAnchor(name: "proportionPlane", transform: hitTestResult.worldTransform)
        sceneView.session.add(anchor: anchor)
    }
    
    func createPlane(ofWidth width: CGFloat, height: CGFloat) -> SCNNode {
        let node = SCNNode()
        node.eulerAngles.x = -.pi / 2
        node.opacity = 0.8
    
        let plane = SCNPlane(width: width, height: height)
        node.geometry = plane
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.planeColor
        return node
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if anchor.name == "proportionPlane" {
            return createPlane(ofWidth: 2.0, height: 2.0)
        }
        
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
}
