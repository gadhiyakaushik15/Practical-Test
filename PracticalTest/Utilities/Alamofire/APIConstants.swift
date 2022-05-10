//
//  APIConstants.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import Foundation

// MARK: This class created for handling Environment and API end points in Project
/*===============================================
* Struct Purpose: -> Call this struct for getting environment stage, which is
  either development or production.
 
* How to Use: -> var baseURL = Environment.Development
* ==============================================*/
struct Environment {
    static let Development = "https://gqro9.mocklab.io/"
    static let Production = ""
}
// ===========end Struct===========================


// Base URL
var baseURL = Environment.Development


/*==============================================
* Struct Purpose: -> Call this struct for getting API endpoints.
 
* How to Use: -> API.home
* =============================================*/
struct API {
    static let home = baseURL + "home?marketCode=%@"
    static let productList = baseURL + "productlist?page=%d&productTagId=%d&marketCode=%@"
}
// =============end Struct========================
