//
//  HomeViewModel.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-05.
//

import Foundation

class HomeViewModel: NSObject {
    // MARK: - Home banner api integration
    func getHomeBanner(marketCode: String, completion:@escaping() -> Void){
        let url = String.init(format: API.home, marketCode)
        let requestHelper = RequestHelper(url: url, method: .get)
        AppLoader.sharedInstance.startLoader()
        APIManager.sharedInstance.request(with: requestHelper) { response in
            AppLoader.sharedInstance.stopLoader()
            if response.error != nil{
//                let json = try? JSONDecoder().decode(FailedLoginModel.self, from: response.responseData!)
//                if let msg = json?.message{
//                    Utilities.sharedInstance.showAlertView(title: "", message: msg)
//                }else{
//                    Utilities.sharedInstance.showAlertView(title: "", message: response.error!.localizedDescription)
//                }
            }else{
//                let json = try? JSONDecoder().decode(LoginModel.self, from: response.responseData!)
//                if let token = json?.data.token{
//                    print(token)
//                    UserDefaults.standard.setValue(token, forKey: StringTitle.accessToken)
//                    completion()
//                }
            }
        }
    }
    
    // MARK: - Product list api integration
    func getProductList(page:Int, productTagId: Int ,marketCode: String, completion:@escaping() -> Void){
        let url = String.init(format: API.productList, page, productTagId, marketCode)
        let requestHelper = RequestHelper(url: url, method: .get)
        AppLoader.sharedInstance.startLoader()
        APIManager.sharedInstance.request(with: requestHelper) { response in
            AppLoader.sharedInstance.stopLoader()
            if response.error != nil {
//                let json = try? JSONDecoder().decode(FailedLoginModel.self, from: response.responseData!)
//                if let msg = json?.message{
//                    Utilities.sharedInstance.showAlertView(title: "", message: msg)
//                }else{
//                    Utilities.sharedInstance.showAlertView(title: "", message: response.error!.localizedDescription)
//                }
            } else {
//                let json = try? JSONDecoder().decode(LoginModel.self, from: response.responseData!)
//                if let token = json?.data.token{
//                    print(token)
//                    UserDefaults.standard.setValue(token, forKey: StringTitle.accessToken)
//                    completion()
//                }
            }
        }
    }
}
