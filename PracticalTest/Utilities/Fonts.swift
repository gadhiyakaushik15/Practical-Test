//
//  Fonts.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import Foundation
import UIKit

// Enum for font
enum CustomFont: String {
    case WorkSans = "WorkSans-"
}

// Enum for font family
enum WorkSansFontFamily: String {
    case bold = "Bold"
    case semiBold = "Semibold"
    case medium = "Medium"
    case regular = "Regular"
}

// Extension to add any custom font used across the project
extension UIFont {
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    class func workSans(family: WorkSansFontFamily, size: CGFloat) -> UIFont {
        let fontName = "\(CustomFont.WorkSans.rawValue)\(family.rawValue)"
        return UIFont(name: fontName, size: size) ?? defaultFont(size: size)
    }
}
