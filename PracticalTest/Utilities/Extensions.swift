//
//  Extensions.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAutoDismissAlert(alertContentText: String, time: Double) {
        let myAlertController = UIAlertController(title: "", message: alertContentText, preferredStyle: UIAlertController.Style.alert)
        self.present(myAlertController, animated: true, completion: nil)
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) {
            myAlertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func getViewController(storyboard: UIStoryboard?, id: String) -> UIViewController? {
        if let controller = storyboard?.instantiateViewController(withIdentifier: id) {
            return controller
        } else {
            return nil
        }
    }
}

extension UIView {
    func resizeTextElements() {
        for index in 0 ..< self.subviews.count {
            let subview: AnyObject = self.subviews[index]
            if subview is UILabel, let label =  subview as? UILabel, let font = label.font {
              label.font = adjustedFontForScreenSize(font)
            } else if subview is UIButton, let button =  subview as? UIButton, let font = button.titleLabel!.font, let titleLabel = button.titleLabel {
                titleLabel.font = adjustedFontForScreenSize(font)
            } else if subview is UITextView, let textView = subview as? UITextView, let font = textView.font {
                textView.font = adjustedFontForScreenSize(font)
            } else if subview is UITextField, let textField = subview as? UITextField, let font = textField.font {
                textField.font = adjustedFontForScreenSize(font)
            } else if subview is UIView, let view = subview as? UIView {
                view.resizeTextElements()
            }
        }
    }
}

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}

extension UIColor {
    static var navigationBarTitle: UIColor {
        return UIColor(named: "navigationBarTitle")!
    }
    static var navigationBarBackground: UIColor {
        return UIColor(named: "navigationBarBackground")!
    }
    static var searchBarText: UIColor {
        return UIColor(named: "searchBarText")!
    }
    static var searchBarTint: UIColor {
        return UIColor(named: "searchBarTint")!
    }
    static var whiteBackground: UIColor {
        return UIColor(named: "whiteBackground")!
    }
}

func adjustedFontForScreenSize(_ font: UIFont!) -> UIFont {
    let fontName = font.fontName
    let fontPointSize = font.pointSize
    let screenWidth = UIScreen.main.bounds.width
    let adjustedFontPointSize = (screenWidth / 375) * fontPointSize
    // ratio is all proportional to 375 screen size
    return UIFont(name: fontName, size: adjustedFontPointSize)!
}
