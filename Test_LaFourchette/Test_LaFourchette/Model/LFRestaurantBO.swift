//
//  LFRestaurantBO.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit
import ObjectMapper

// Interface used to communicate with Presenter & layout Strategy Layers
protocol LFRestaurantDataInterface: class {
    func restaurantName()                       -> String?;
    func restaurantAddress()                    -> String?;
    func restaurantImageURL(atIndex index: Int) -> String?;
    func numberOfImages()                       -> Int;
}

// Use to format data correctly base on restaurant BO
class LFRestaurantDecorator: NSObject, LFRestaurantDataInterface {
 
    var restaurant  : LFRestaurantBO!;
    
    // MARK: Constructor
    init(restaurant: LFRestaurantBO) {
        super.init();
        self.restaurant = restaurant;
    }
    
    // MARK: LFRestaurantDataInterface
    func restaurantName()       -> String? { return self.restaurant.name; }
    func restaurantAddress()    -> String? {
        if let address = self.restaurant.address {
            if let city = self.restaurant.city {
                if let zipCode = self.restaurant.zipCode {
                    return NSString(format: "%@ %@ %@", address, zipCode, city) as String;
                }
            }
        }
        return nil;
    }
    func restaurantImageURL(atIndex index: Int) -> String?  { return self.restaurant.imageURL(atIndex: index); }
    func numberOfImages()                       -> Int      { return self.restaurant.numberOfImages(); }
}

class LFRestaurantBO: Mappable {
   
    static let DATA_KEY                             : String = "data";
    
    // Private keys used to parse data
    private let RESTAURANT_ID_KEY                   : String = "idRestaurant";
    private let RESTAURANT_NAME_KEY                 : String = "name";
    private let RESTAURANT_ADDRESS_KEY              : String = "address";
    private let RESTAURANT_CITY_KEY                 : String = "city";
    private let RESTAURANT_ZIPCODE_KEY              : String = "zipcode";
    private let RESTAURANT_GPS_LAT_KEY              : String = "gps_lat";
    private let RESTAURANT_GPS_LNG_KEY              : String = "gps_long";
    private let RESTAURANT_RATE_COUNT_KEY           : String = "rate_count";
    private let RESTAURANT_PICS_DIAPORAMA_KEY       : String = "pics_diaporama";
    
    // Attributes
    private var idRestaurant                        : String?;
    private var name                                : String?;
    private var address                             : String?;
    private var city                                : String?;
    private var zipCode                             : String?;
    private var addressLatitude                     : Double?;
    private var addressLongitude                    : Double?;
    private var rateCount                           : Int?;
    private var imagesURL                           : [LFRestaurantDiapoBO]?;
    
    // MARK: Constructor
    required init?(_ map: Map) {}
    
    // MARK: Mapping function
    func mapping(map: Map) {
        idRestaurant        <- map[RESTAURANT_ID_KEY];
        name                <- map[RESTAURANT_NAME_KEY];
        address             <- map[RESTAURANT_ADDRESS_KEY];
        city                <- map[RESTAURANT_CITY_KEY];
        zipCode             <- map[RESTAURANT_ZIPCODE_KEY];
        addressLatitude     <- map[RESTAURANT_GPS_LAT_KEY];
        addressLongitude    <- map[RESTAURANT_GPS_LNG_KEY];
        rateCount           <- map[RESTAURANT_RATE_COUNT_KEY];
        imagesURL           <- map[RESTAURANT_PICS_DIAPORAMA_KEY];
    }
    
    // MARK: Public function
    func imageURL(atIndex index: Int) -> String? {
        if let images = self.imagesURL {
            if (index >= 0 && index < images.count) {
                return images[index].imageURL;
            }
        }
        return nil;
    }
    
    func numberOfImages() -> Int {
        if let images = self.imagesURL {
            return images.count;
        }
        return 0;
    }
}

class LFRestaurantDiapoBO: Mappable {
    
    // Private keys used to parse data
    private let RESTAURANT_PICS_DIAPORAMA_SIZE_KEY  : String = "480x270";
    
    // Attributes
    private var imageURL    : String?;
    
    // MARK: Constructor
    required init?(_ map: Map) {}
    
    // MARK: Mapping function
    func mapping(map: Map) {
        imageURL <- map[RESTAURANT_PICS_DIAPORAMA_SIZE_KEY];
    }
}