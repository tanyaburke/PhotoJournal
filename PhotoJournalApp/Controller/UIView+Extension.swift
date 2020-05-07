//
//  UIView+Extension.swift
//  PhotoJournalApp
//
//  Created by Tanya Burke on 5/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public static func resetWindow(with rootViewController: UIViewController) {
        
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        
        window.rootViewController = rootViewController
    }
    
    
    public static func showViewController(storyboardName: String , viewControllerID: String) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let newVC = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        resetWindow(with: newVC)
    }
    
    
}

