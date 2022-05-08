//
//  APIManager.swift
//  PracticalTest
//
//  Created by Ankur Kathiriya on 04/05/22.
//

import Foundation
import Alamofire

final class APIManager{
    
    static let sharedInstance: APIManager = APIManager()
    
    func request(with requestHelper: RequestHelper?,completion : ((_ response : ResponseHelper) -> Void)?) {
        
        // Create request
        guard let requestData = requestHelper, let url = try? requestData.url.asURL() else {
            let responseData = ResponseHelper(responseData: nil, error: nil)
            completion?(responseData)
            return
        }
        
        // API call
        AF.request(url, method: requestData.method, parameters: requestData.parameters) .responseData {
            response in
            switch response.result {
            case .success:
                print(response.result)
                let responseData = ResponseHelper(responseData: response.data, error: response.error)
                completion?(responseData)
                break
            case .failure(let error):
                print(error)
                let responseData = ResponseHelper(responseData: response.data, error: error)
                completion?(responseData)
                break
            }
        }
    }
    
    // Internet reachability checking
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

// Request helper struct
struct RequestHelper {
    let url: URLConvertible
    var method: HTTPMethod = .get
    var parameters: Parameters = [:]
    var encoding: ParameterEncoding = URLEncoding.default
    var headers: [String : String]? = nil
    
    init(url: URLConvertible, method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    init(url: URLConvertible, method: HTTPMethod, parameters: Parameters) {
        self.url = url
        self.method = method
        self.parameters = parameters
    }
    
    init(url: URLConvertible, method: HTTPMethod, headers: [String : String]?) {
        self.url = url
        self.method = method
        self.headers = headers
    }
    
    init(url: URLConvertible, method: HTTPMethod, parameters: Parameters, headers: [String : String]?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    init(url: URLConvertible, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: [String : String]?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
}

// Response Helper struct
struct ResponseHelper {
    let responseData : Data?
    let error : Error?
    init(responseData : Data?, error : Error?) {
        self.responseData = responseData
        self.error = error
    }
}
