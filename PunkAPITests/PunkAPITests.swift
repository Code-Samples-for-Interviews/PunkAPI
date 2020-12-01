//
//  PunkAPITests.swift
//  PunkAPITests
//
//  Created by Diego Jimenez on 22/10/2020.
//

import XCTest

@testable import PunkAPI

class PunkAPITests: XCTestCase {
    
    var beerArrayDummyData: Data {
        let beerJson = ["id":192,"name":"Punk IPA 2007 - 2010","tagline":"Post Modern Classic. Spiky. Tropical. Hoppy.","first_brewed":"04/2007","description":"Our flagship beer that kick started the craft beer revolution. This is James and Martin's original take on an American IPA, subverted with punchy New Zealand hops. Layered with new world hops to create an all-out riot of grapefruit, pineapple and lychee before a spiky, mouth-puckering bitter finish.","image_url":"https://images.punkapi.com/v2/192.png","abv":6.0,"ibu":60.0,"target_fg":1010.0,"target_og":1056.0,"ebc":17.0,"srm":8.5,"ph":4.4,"attenuation_level":82.14,"volume":["value":20,"unit":"liters"],"boil_volume":["value":25,"unit":"liters"],"method":["mash_temp":[["temp":["value":65,"unit":"celsius"],"duration":75]],"fermentation":["temp":["value":19.0,"unit":"celsius"]],"twist":nil],"ingredients":["malt":[["name":"Extra Pale","amount":["value":5.3,"unit":"kilograms"]]],"hops":[["name":"Ahtanum","amount":["value":17.5,"unit":"grams"],"add":"start","attribute":"bitter"],["name":"Chinook","amount":["value":15,"unit":"grams"],"add":"start","attribute":"bitter"]],"yeast":"Wyeast 1056 - American Ale™"],"food_pairing":["Spicy carne asada with a pico de gallo sauce","Shredded chicken tacos with a mango chilli lime salsa","Cheesecake with a passion fruit swirl sauce"],"brewers_tips":"While it may surprise you, this version of Punk IPA isn't dry hopped but still packs a punch! To make the best of the aroma hops make sure they are fully submerged and add them just before knock out for an intense hop hit.","contributed_by":"Sam Mason <samjbmason>"] as [String: Any]
        let array = [beerJson]
        let data = try! JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        return data
    }
    
    func testBeerViewModel() {
        let beerDummy = Beer(name: "Beer Name", imageUrl: "http://fakeUrl", description: "descriptionText", tagline: "tagline", abv: 99, ibu: 66)
        XCTAssertNotNil(beerDummy)
        let beerViewModel = BeerViewModel(beer: beerDummy)
        XCTAssertNotNil(beerViewModel)
        XCTAssertEqual(beerViewModel.nameText, "Beer Name")
        XCTAssertEqual(beerViewModel.descriptionText, "descriptionText")
        XCTAssertEqual(beerViewModel.pictureUrl, URL(string: "http://fakeUrl"))
    }
    
    func testFetchBeers() {
        let testExpectation = expectation(description: "Test fetching remote Beers")
        
        let beerServices = APIService()
        beerServices.fetchBeersForFood(search: "carne", page: 1, completion: { (error, beerList) in
            dump(beerList)
            XCTAssert(error == nil)
            XCTAssert(beerList.count > 0)
            testExpectation.fulfill()
        })
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testParser() {
        let service = APIService()
        let beerData = beerArrayDummyData
        let beers = service.parseResponse(beerData)
        XCTAssertNotNil(beers)
        XCTAssertEqual(beers?.count, 1)
        dump(beers)
        let beer = beers?.first
        XCTAssertEqual(beer?.name, "Punk IPA 2007 - 2010")
    }
    
    

    // MARK: - Initial methods
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
