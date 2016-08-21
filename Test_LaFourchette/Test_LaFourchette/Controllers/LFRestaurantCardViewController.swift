//
//  LFRestaurantCardViewController.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantCardViewController: UIViewController {

    private var presenter   : LFRestaurantCardPresenter!;
    var restaurant          : LFRestaurantDataInterface?;
    
    deinit {
        self.restaurant = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let restaurant = self.restaurant {
            presenter = LFRestaurantCardPresenter(layoutStrategy: LFRestaurantCardCollectionViewLayoutStrategy(dataInterface: restaurant));
            if let restaurantCardView = self.view as? LFRestaurantCardView {
                restaurantCardView.bindViewWithPresenter(presenter);
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
