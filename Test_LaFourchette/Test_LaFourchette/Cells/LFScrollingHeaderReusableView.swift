//
//  LFScrollingHeaderReusableView.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

protocol LFScrollingHeaderReusableViewDelegate: class {
    func scrollToNextPhoto(atIndex index: Int, headerView: LFScrollingHeaderReusableView);
    func shouldScrollToChildView(photoIndex: Int, direction: Int);
}

class LFScrollingHeaderReusableView: UICollectionReusableView, UIScrollViewDelegate {
    
    private let TAG         : Int = 1000;
    static let IDENTIFIER   : String  = "LFScrollingHeaderReusableView";
    static let HEIGHT       : CGFloat = 184.0;
    
    @IBOutlet private weak var scrollView       : UIScrollView!;
    @IBOutlet private weak var labelTitle       : UILabel!;
    @IBOutlet private weak var labelSubtitle    : UILabel!;
    
    weak var presenterDelegate                  : LFScrollingHeaderReusableViewDelegate?;
    
    deinit {
        self.presenterDelegate = nil;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.labelTitle.text    = nil;
        self.labelSubtitle.text = nil;
    }
    
    // MARK: Public methods
    func populateSubviews(nbElements nbElements: Int, width: CGFloat, height: CGFloat) {
        if (self.scrollView.subviews.count == 0) {
            var origin = CGPointZero;
            for index in 0...(nbElements-1) {
                let componentView = LFImageHeaderComponentView(frame: CGRectMake(origin.x, 0, width, height));
                componentView.tag = TAG + index;
                scrollView.addSubview(componentView);
                origin.x += width;
            }
            scrollView.contentSize = CGSizeMake(ceil(CGFloat(nbElements) * width), height)
            self.bringSubviewToFront(self.labelTitle);
            self.bringSubviewToFront(self.labelSubtitle);
        }
    }
    
    func refreshHeader(title title: String?, subtitle: String?) {
        self.labelTitle.text    = title;
        self.labelSubtitle.text = subtitle;
    }
    
    func loadImage(imageURL url: String?, atIndex: Int) {
        if let imageURL = url {
            if let componentView = self.scrollView.viewWithTag(TAG + atIndex) as? LFImageHeaderComponentView {
                componentView.loadImage(imageURL: imageURL, atIndex: atIndex);
            }            
        }
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let indexPhoto = lround(Double(scrollView.contentOffset.x) / Double(CGRectGetWidth(scrollView.frame)));
        self.presenterDelegate?.scrollToNextPhoto(atIndex: indexPhoto, headerView: self);
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let indexPhoto = lround(Double(scrollView.contentOffset.x) / Double(CGRectGetWidth(scrollView.frame)));
        
        let velocityPoint = scrollView.panGestureRecognizer.velocityInView(self);
        let isVerticalGesture = fabs(velocityPoint.y) > fabs(velocityPoint.x);
        var scrollDirection = 0;
        if (!isVerticalGesture) {
            let translationPoint = scrollView.panGestureRecognizer.translationInView(self.superview);
            scrollDirection = (translationPoint.x > 0.0) ? 1 : 2;
        }
        
        // Scroll Right
        if (scrollDirection == 2 && (scrollView.contentOffset.x > (CGFloat(indexPhoto) * CGRectGetWidth(scrollView.frame)))) {
            self.presenterDelegate?.shouldScrollToChildView(indexPhoto, direction: scrollDirection);
        }
        else if (scrollDirection == 1 && (scrollView.contentOffset.x < (CGFloat(indexPhoto) * CGRectGetWidth(scrollView.frame)))) { // Scroll Left
            self.presenterDelegate?.shouldScrollToChildView(indexPhoto, direction: scrollDirection);
        }
    }
}