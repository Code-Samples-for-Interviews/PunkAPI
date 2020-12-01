//
//  APIRouter.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import Foundation
import Alamofire
 

enum APIRouter: URLRequestConvertible {

    static let itemsPerPage = 20
    
    static let pageUrl = "https://api.punkapi.com/v2/"
    case fetchBeers(food: String, page: Int)
    
    var path: String {
        switch self {
            case .fetchBeers(let food, let page):
                return "beers?food=\(food)&page=\(page)&per_page=\(APIRouter.itemsPerPage)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.pageUrl.asURL()
        let newUrlString = url.absoluteString + path
        var urlRequest = URLRequest(url: URL(string: newUrlString)!)
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil )
        return urlRequest
    }
}

