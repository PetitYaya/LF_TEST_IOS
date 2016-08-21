//
//  LFScrollingHeaderReusableView.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFScrollingHeaderReusableView: UICollectionReusableView {
    
    static let IDENTIFIER : String  = "LFScrollingHeaderReusableView";
    static let HEIGHT     : CGFloat = 150.0;
    
    @IBOutlet private weak var scrollView       : UIScrollView!;
    @IBOutlet private weak var labelTitle       : UILabel!;
    @IBOutlet private weak var labelSubtitle    : UILabel!;
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.labelTitle.text    = nil;
        self.labelSubtitle.text = nil;
    }
    
    // MARK: Public methods
    func populateSubviews(width width: CGFloat, height: CGFloat) {
        if (self.scrollView.subviews.count == 0) {
            let colors = [UIColor.orangeColor(), UIColor.grayColor(), UIColor.greenColor()];
            var origin = CGPointZero;
            for index in 0...2 {
                let componentView = LFImageHeaderComponentView(frame: CGRectMake(origin.x, 0, width, height));
                componentView.tag = 1000 + index;
                componentView.backgroundColor = colors[index];
                scrollView.addSubview(componentView);
                origin.x += width;
            }
            scrollView.contentSize = CGSizeMake(ceil(CGFloat(colors.count) * width), height)
        }
    }
    
    func refreshHeader(title title: String?, subtitle: String?) {
        self.labelTitle.text    = title;
        self.labelSubtitle.text = subtitle;
    }
}