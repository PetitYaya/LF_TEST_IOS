//
//  LFRestaurantContainerPresenter.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantContainerPresenter: NSObject {

    // TEST Purpose only : In real context, should be dynamic...
    private let RESTAURANTS_IDS = [6861, 40370, 16409, 14163];
    
    // MARK: Public Methods
    func downloadRestaurants(successBlock:([LFRestaurantDataInterface]) -> Void, failureBlock: (NSError?) -> Void) {
        var restaurants = [LFRestaurantDataInterface]();
        for idRestaurant in RESTAURANTS_IDS {
            LFNetworkManager.sharedInstance.downloadRestaurant(idRestaurant: idRestaurant, successBlock: { [weak self] (restaurant) in
                if let weakSelf = self {
                    restaurants.append(restaurant);
                    if (restaurants.count == (weakSelf.RESTAURANTS_IDS.count)) {
                        successBlock(restaurants);
                    }
                }
            }) { (error) in
                failureBlock(error);
            }
        }
    }
}