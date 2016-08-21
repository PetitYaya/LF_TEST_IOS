//
//  LFContainerViewController.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFContainerViewController: UIViewController {

    private var presenter   : LFRestaurantContainerPresenter!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = LFRestaurantContainerPresenter();
        if let containerView = self.view as? LFContainerView {
            containerView.bindViewWithPresenter(presenter);
            presenter.downloadRestaurants({ (restaurants) in
                containerView.initializeChildControllers(restaurants: restaurants, parentController: self);
            }) { (error) in
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}