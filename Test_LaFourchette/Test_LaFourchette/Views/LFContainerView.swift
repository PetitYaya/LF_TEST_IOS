//
//  LFContainerView.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFContainerView: UIView, LFRestaurantContainerPresenterViewDelegate {

    @IBOutlet private weak var scrollView: UIScrollView!;
    
    // MARK: Private Methods
    /* This private method is used to setup correctly our controllers (position, frame) */
    private func populateViewWithChildControllers(containerController containerController: UIViewController, childControllers: [UIViewController]) {
        var origin : CGPoint = CGPointZero;
        for childController in childControllers {
            
            childController.willMoveToParentViewController(containerController);
            childController.view.frame = scrollView.bounds;
            childController.view.frame.origin = origin;
            
            scrollView.addSubview(childController.view);
            containerController.addChildViewController(childController);
            childController.didMoveToParentViewController(containerController);
            
            origin.x += CGRectGetWidth(UIScreen.mainScreen().bounds);
        }
        scrollView.contentSize = CGSize(width: CGFloat(childControllers.count) * CGRectGetWidth(UIScreen.mainScreen().bounds), height: 0);
    }
    
    // MARK: Public Methods
    /* This method is used to initialize all children for a navigation inside the current scrollview */
    func initializeChildControllers(restaurants restaurants: [LFRestaurantDataInterface], parentController: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        var childControllers = [UIViewController]();
        for restaurant in restaurants {
            if let restaurantCardVC = storyboard.instantiateViewControllerWithIdentifier("LFRestaurantCardViewController") as? LFRestaurantCardViewController {
                restaurantCardVC.restaurant = restaurant;
                childControllers.append(restaurantCardVC);
            }
        }
        self.populateViewWithChildControllers(containerController: parentController, childControllers: childControllers);
    }
    
    func bindViewWithPresenter(presenter: LFRestaurantContainerPresenter) {
        presenter.viewDelegate = self;
    }
    
    // MARK: LFRestaurantContainerPresenterViewDelegate
    func moveToChildViewController(atIndex: Int) {
        self.scrollView.setContentOffset(CGPointMake(CGRectGetWidth(scrollView.frame) * CGFloat(atIndex), 0), animated: true);
    }
}