//
//  Languages.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-08.
//

import Foundation

enum Languages: String, CaseIterable {
    case english

    var sortName: String {
        switch self {
        case .english:
            return "en"
        }
    }
}
