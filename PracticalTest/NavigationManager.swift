//
//  NavigationManager.swift
//  creditt
//
//  Created by Test Device on 21/02/22.
//

import Foundation
import UIKit

struct NavigationManager {
    static func setRootViewControllerWithNavigation(controller: UIViewController?, animated: Bool = true) {
        guard let controller = controller, let window = appDelegate?.window else { return }
        let navigation = CustomNavigationController(rootViewController: controller)
        if animated {
            window.rootViewController = navigation
            let options = UIView.AnimationOptions.transitionCrossDissolve
            let duration = 0.1
            UIView.transition(with: window, duration: duration, options: options, animations: {})
        } else {
           window.rootViewController = navigation
        }
    }
    static func setRootViewController(controller: UIViewController?, animated: Bool = true) {
        guard let controller = controller, let window = appDelegate?.window else { return }
        if animated {
            window.rootViewController = controller
            let options = UIView.AnimationOptions.transitionCrossDissolve
            let duration = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {})
        } else {
           window.rootViewController = controller
        }
    }
}
