//
//  Utilities.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import Foundation
import UIKit

class Utilities {
    
    static let sharedInstance = Utilities()
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first

    func showAlertView(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
    
   // MARK: Convert Number To Currency Format
   func convertNumberToCurrencyFormat(number: Double) -> String {
       let formatter = NumberFormatter()
       formatter.locale = Locale(identifier: "en_UZS")
       formatter.numberStyle = .currency
       formatter.currencySymbol = "UZS"
       if number.truncatingRemainder(dividingBy: 1) == 0 {
           formatter.maximumFractionDigits = 0
       } else {
           formatter.maximumFractionDigits = 1
       }
       return formatter.string(from: NSNumber(value: number))!
   }
}
