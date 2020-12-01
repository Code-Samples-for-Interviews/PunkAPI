//
//  APIService.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import Foundation

class APIService: APIClient {
    func fetchBeersForFood(search: String, page: Int, completion:@escaping (_ error: Error?, _ beerList:[BeerViewModel]) -> Void) {
        self.request(APIRouter.fetchBeers(food: search, page: page)) {[weak self] (data, error) in
            guard let data = data else {
                completion(error, [])
                return
            }
            
            guard let beers = self?.parseResponse(data) else {
                completion(APIClientError.jsonParsingError, [])
                return
            }
            let vms = beers.compactMap {BeerViewModel(beer: $0)}
            completion(nil, vms)
        }
    }
    
    func parseResponse(_ data: Data) -> [Beer]? {
        do {
            let decoder = JSONDecoder()
            let beerList = try decoder.decode([Beer].self, from: data)
            return beerList
        }
        catch {
            return nil
        }
    }
}


