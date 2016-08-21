//
//  LFImageHeaderComponentView.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFImageHeaderComponentView: UIView {

    @IBOutlet private weak var view                     : UIView!;
    @IBOutlet private weak var imgView                  : UIImageView!;
    @IBOutlet private weak var activityIndicatorView    : UIActivityIndicatorView!;
  
    // MARK: Constructor
    override func awakeFromNib() {
        super.awakeFromNib();
        self.setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
        self.view.frame = self.bounds;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setup() {
        NSBundle.mainBundle().loadNibNamed("LFImageHeaderComponentView", owner: self, options: nil);
        self.addSubview(self.view);
    }
    
    // MARK: Public Methods
    
}
