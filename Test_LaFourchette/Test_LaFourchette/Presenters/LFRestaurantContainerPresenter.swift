//
//  LFRestaurantContainerPresenter.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

protocol LFRestaurantContainerPresenterViewDelegate: class {
    func moveToChildViewController(atIndex: Int);
}

class LFRestaurantContainerPresenter: NSObject {

    static let MOVE_TO_NEXT_CONTROLLER_NOTIFICATION : String = "MoveToNextChildViewController";
    static let MOVE_TO_PREV_CONTROLLER_NOTIFICATION : String = "MoveToPrevChildViewController";
    
    
    // TEST Purpose only : In real context, should be dynamic...
    private let RESTAURANTS_IDS = [6861, 40370, 16409, 14163];
    private var currentPage     : Int = 0;
    weak var viewDelegate       : LFRestaurantContainerPresenterViewDelegate?;

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: LFRestaurantContainerPresenter.MOVE_TO_NEXT_CONTROLLER_NOTIFICATION, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: LFRestaurantContainerPresenter.MOVE_TO_PREV_CONTROLLER_NOTIFICATION, object: nil);
        self.viewDelegate = nil;
    }
    
    override init() {
        super.init();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LFRestaurantContainerPresenter.moveToNextChildViewController),
                                                         name: LFRestaurantContainerPresenter.MOVE_TO_NEXT_CONTROLLER_NOTIFICATION,
                                                         object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LFRestaurantContainerPresenter.moveToPrevChildViewController),
                                                         name: LFRestaurantContainerPresenter.MOVE_TO_PREV_CONTROLLER_NOTIFICATION,
                                                         object: nil);
    }
    
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
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let newPage = lround(Double(scrollView.contentOffset.x) / Double(CGRectGetWidth(scrollView.frame)));
        self.currentPage = newPage;
    }
    
    // MARK: Notification
    func moveToNextChildViewController() {
        if (currentPage + 1 < RESTAURANTS_IDS.count) {
            self.viewDelegate?.moveToChildViewController(currentPage + 1);
            currentPage += 1;
        }
    }
    
    func moveToPrevChildViewController() {
        if (currentPage > 0) {
            self.viewDelegate?.moveToChildViewController(currentPage - 1);
            currentPage -= 1;
        }
    }
}