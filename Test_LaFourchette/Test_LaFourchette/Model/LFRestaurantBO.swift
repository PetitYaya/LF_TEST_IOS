//
//  LFRestaurantBO.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit
import ObjectMapper

class LFRestaurantDecorator: NSObject {
 
    var restaurant  : LFRestaurantBO!;
    
    // MARK: Constructor
    init(restaurant: LFRestaurantBO) {
        super.init();
        self.restaurant = restaurant;
    }
}

class LFRestaurantBO: Mappable {
   
    static let DATA_KEY                     : String = "data";
    
    // Private keys used to parse data
    private let RESTAURANT_ID_KEY           : String = "idRestaurant";
    private let RESTAURANT_NAME_KEY         : String = "name";
    private let RESTAURANT_ADDRESS_KEY      : String = "address";
    private let RESTAURANT_GPS_LAT_KEY      : String = "gps_lat";
    private let RESTAURANT_GPS_LNG_KEY      : String = "gps_long";
    private let RESTAURANT_RATE_COUNT_KEY   : String = "rate_count";
    
    // Attributes
    private var idRestaurant                : String?;
    private var name                        : String?;
    private var address                     : String?;
    private var addressLatitude             : Double?;
    private var addressLongitude            : Double?;
    private var rateCount                   : Int?;
    
    // MARK: Constructor
    required init?(_ map: Map) {}
    
    // MARK: Mapping function
    func mapping(map: Map) {
        idRestaurant        <- map[RESTAURANT_ID_KEY];
        name                <- map[RESTAURANT_NAME_KEY];
        address             <- map[RESTAURANT_ADDRESS_KEY];
        addressLatitude     <- map[RESTAURANT_GPS_LAT_KEY];
        addressLongitude    <- map[RESTAURANT_GPS_LNG_KEY];
        rateCount           <- map[RESTAURANT_RATE_COUNT_KEY];
    }
}