//
//  LFRestaurantCardView.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantCardView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: Public Methods
    /* For debug purpose, need to be removed */
    func setupBackgroundColor(color: UIColor?) {
        self.collectionView.backgroundColor = color;
    }

}
