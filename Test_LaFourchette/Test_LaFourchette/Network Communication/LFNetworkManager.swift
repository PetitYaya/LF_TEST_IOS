//
//  LFNetworkManager.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

/* Interface used in order to download restaurant */
protocol LFNetworkRestaurantInterface: class {
    func baseURLString(method method: String) -> String;
    func downloadRestaurant(idRestaurant idRestaurant: Int,
                                         successBlock:(LFRestaurantDataInterface) -> Void,
                                         failureBlock:(NSError?) -> Void)
}

class LFNetworkManager: NSObject, LFNetworkRestaurantInterface {
    
    // MARK: Singleton Pattern
    static let sharedInstance = LFNetworkManager();
    private override init() {}
    
    
    // MARK: LFNetworkRestaurantInterface
    
    /* Base URL used for requests */
    func baseURLString(method method: String) -> String { return NSString(format: LFNetworkEndpoints.API_BASE_URL, LFNetworkEndpoints.API_KEY, method) as String; }
    
    /* Implementation of th edownload request */
    func downloadRestaurant(idRestaurant idRestaurant: Int, successBlock: (LFRestaurantDataInterface) -> Void, failureBlock: (NSError?) -> Void) {

        // Format URL String
        let urlString = NSString(format: LFNetworkEndpoints.GET_RESTAURANT_ENDPOINT, baseURLString(method: LFNetworkEndpoints.GET_RESTAURANT_METHOD), NSString(format: "%d", idRestaurant) as String) as String;
        
        // Make request
        Alamofire.request(.GET, urlString).validate().responseObject(keyPath: LFRestaurantBO.DATA_KEY) { (response: Response<LFRestaurantBO, NSError>) in
            switch response.result {
            case .Success(let restaurant):
                successBlock(LFRestaurantDecorator(restaurant: restaurant));
                break
                
            case .Failure(let error):
                failureBlock(error);
                break;
            }
        }
    }
}