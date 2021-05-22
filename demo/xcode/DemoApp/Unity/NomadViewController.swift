//
//  NomadViewController.swift
//  Nomad Integartion
//
//  Created by 정유빈 on 26/11/2019.
//  Copyright © 2019 Team Nomad. All rights reserved.
//

import Foundation
import UIKit

@objc class NomadViewController: UIViewController {
    @objc public static var Shared: NomadViewController?
    @objc
    public init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    @objc public func dismiss(){
        self.dismiss(animated: true, completion: nil)
        if let appDelegate = UIApplication.shared.delegate as? MFAppDelegate{
            appDelegate.stopUnity()
        }
        NotificationCenter.default.post(name: NSNotification.Name("DidUnityDismiss"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NomadViewController.Shared = self
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.startUnity()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handleUnityReady()
    }

    @objc func handleUnityReady() {
        showUnitySubView()
        
        // Example
        // UnityPostMessage("UnityHandlingManager", "OnSessionEvent", aAuthToken)
    }

    
    func showUnitySubView() {
        if let unityView = UnityGetGLView() {
            // insert subview at index 0 ensures unity view is behind current UI view
            view?.insertSubview(unityView, at: 0)

            unityView.translatesAutoresizingMaskIntoConstraints = false
            let views = ["view": unityView]
            let w = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|", options: [], metrics: nil, views: views)
            let h = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: views)
            view.addConstraints(w + h)
        }
    }
}
