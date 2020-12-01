//
//  BeerViewModel.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import Foundation

struct BeerViewModel {
    
    private let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
    
    // Model formating
    var nameText: String { return beer.name }
    var descriptionText: String { return beer.description }
    var taglineText: String { return beer.tagline }
    var abvText: String { return String("\(beer.abv)") }
    var ibuText: String? {
        guard let ibu = beer.ibu else {
            return "---"
        }
        return String("\(ibu)")
    }
    var pictureUrl: URL? { return URL(string: beer.imageUrl) }
}

