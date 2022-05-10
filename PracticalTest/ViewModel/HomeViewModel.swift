//
//  HomeViewModel.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-05.
//

import Foundation

class HomeViewModel: NSObject {
    // MARK: - Home banner api integration
    func getHomeBanner(marketCode: String, completion: @escaping(BannerModel) -> Void) {
        let url = String.init(format: API.home, marketCode)
        let requestHelper = RequestHelper(url: url, method: .get)
        AppLoader.sharedInstance.startLoader()
        APIManager.sharedInstance.request(with: requestHelper) { response in
            if response.error != nil {
                AppLoader.sharedInstance.stopLoader()
                Utilities.sharedInstance.showAlertView(title: "", message: response.error!.localizedDescription)
            } else {
                let json = try? JSONDecoder().decode(BannerModel.self, from: response.responseData!)
                if let data = json {
                    completion(data)
                } else {
                    AppLoader.sharedInstance.stopLoader()
                    Utilities.sharedInstance.showAlertView(title: "", message: localizationBundle.localizedString(forKey: "SomethingWentWrong", value: "Search for products", table: nil))
                }
            }
        }
    }
    
    // MARK: - Product list api integration
    func getProductList(page: Int, productTagId: Int, marketCode: String, completion:@escaping(ProductListModel) -> Void) {
        let url = String.init(format: API.productList, page, productTagId, marketCode)
        let requestHelper = RequestHelper(url: url, method: .get)
        APIManager.sharedInstance.request(with: requestHelper) { response in
            AppLoader.sharedInstance.stopLoader()
            if response.error != nil {
                Utilities.sharedInstance.showAlertView(title: "", message: response.error!.localizedDescription)
            } else {
                let json = try? JSONDecoder().decode(ProductListModel.self, from: response.responseData!)
                if let data = json {
                    completion(data)
                } else {
                    Utilities.sharedInstance.showAlertView(title: "", message: localizationBundle.localizedString(forKey: "SomethingWentWrong", value: "Search for products", table: nil))
                }
            }
        }
    }
}
