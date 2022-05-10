//
//  CustomNavigationController.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.shadowColor = .clear
            navBarAppearance.backgroundColor = .navigationBarBackground
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navigationBarTitle, .font: adjustedFontForScreenSize(UIFont.workSans(family: .semiBold, size: 20))]
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.barTintColor = .navigationBarBackground
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.navigationBarTitle, .font: adjustedFontForScreenSize(UIFont.workSans(family: .semiBold, size: 20))]
        }
        self.navigationBar.tintColor = .navigationBarTitle
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
