//
//  LFMenuCollectionViewCell.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelLeft    : UILabel!;
    @IBOutlet private weak var labelCenter  : UILabel!;
    @IBOutlet private weak var labelRight   : UILabel!;
    
    static let IDENTIFIER   : String = "LFMenuCollectionViewCell";
    static let HEIGHT       : CGFloat = 50.0;
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.labelLeft.text = nil;
        self.labelCenter.text = nil;
    }
    
    // MARK: Public methods
    func configureCell(leftTitle leftTitle: String?, centerTitle: String?, rightTitle: String?) {
        self.labelLeft.text     = leftTitle;
        self.labelCenter.text   = centerTitle;
        self.labelRight.text    = rightTitle;
    }
}
