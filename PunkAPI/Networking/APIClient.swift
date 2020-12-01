//
//  APIClient.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import Foundation
import Alamofire

enum APIClientError: Error {
    case jsonParsingError
    case serverError
    case other
    var localizedDescription: String { return "Error, intentalo de nuevo." }
}

protocol APIClient {
    func request(_ request: URLRequestConvertible, completion: @escaping ((Data?, Error?) -> Void))
}

extension APIClient {
    func request(_ request: URLRequestConvertible, completion: @escaping ((Data?, Error?) -> Void)) {
        AF.request(request)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(_):
                        completion(response.data, nil)
                case .failure(_):
                        completion(nil, APIClientError.serverError)
                }
        }
    }
}
