//
//  LFRestaurantMapCollectionViewCell.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantMapCollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER   : String = "LFRestaurantMapCollectionViewCell";
    
    // MARK: Class methods
    static func heightForCell() -> CGFloat {
        return CGRectGetHeight(UIScreen.mainScreen().bounds) - LFScrollingHeaderReusableView.HEIGHT - LFMenuCollectionViewCell.HEIGHT - LFRestaurantDescriptionCollectionViewCell.HEIGHT;
    }
}
