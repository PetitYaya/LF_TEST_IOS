//
//  LFRestaurantCardPresenter.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantCardPresenter: NSObject {

    private var layoutStrategy : LFRestaurantCardLayoutStrategy!;
    
    // MARK: Constructor
    init(layoutStrategy: LFRestaurantCardLayoutStrategy) {
        super.init();
        self.layoutStrategy = layoutStrategy;
    }
    
    // MARK: Public Methods
    func retrieveLayout() -> LFRestaurantCardLayoutStrategy { return self.layoutStrategy; }
}
