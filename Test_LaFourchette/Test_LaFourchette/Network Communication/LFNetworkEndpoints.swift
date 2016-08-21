//
//  LFNetworkEndpoints.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFNetworkEndpoints: NSObject {

    /* API key used to communicate with LF server */
    static let API_KEY                  : String = "IPHONEPRODEDCRFV";
    
    /* Base API URL to be reused for future request */
    static let API_BASE_URL             : String = "http://api.lafourchette.com/api?key=%@&method=%@";
    
    /* Endpoint GET_RESTAURANT */
    static let GET_RESTAURANT_ENDPOINT  : String = "%@&id_restaurant=%@";
    static let GET_RESTAURANT_METHOD    : String = "restaurant_get_info";
}
