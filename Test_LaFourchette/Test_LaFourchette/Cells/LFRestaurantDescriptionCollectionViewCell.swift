//
//  LFRestaurantDescriptionCollectionViewCell.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantDescriptionCollectionViewCell: UICollectionViewCell {
 
    static let IDENTIFIER   : String = "LFRestaurantDescriptionCollectionViewCell";
    static let HEIGHT       : CGFloat = 60.0;
    
    @IBOutlet private weak var labelTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.labelTitle.attributedText = nil;
    }
    
    // MARK: Public Methods
    func configureCell(title title: NSAttributedString?) {
        self.labelTitle.attributedText = title;
    }
}
