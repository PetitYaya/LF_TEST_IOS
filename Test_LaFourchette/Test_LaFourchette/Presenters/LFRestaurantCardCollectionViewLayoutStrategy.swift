//
//  LFRestaurantCardCollectionViewLayoutStrategy.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantCardLayoutStrategy: NSObject, LFScrollingHeaderReusableViewDelegate {

    internal var restaurant             : LFRestaurantDataInterface!;
    internal var currentPhotoIndex      : Int = 0;
    internal var isScrolling            : Bool = false;

    // MARK: Constructor
    init(dataInterface: LFRestaurantDataInterface) {
        super.init();
        self.restaurant = dataInterface;
    }
    
    // MARK: LFScrollingHeaderReusableViewDelegate
    func scrollToNextPhoto(atIndex index: Int, headerView: LFScrollingHeaderReusableView) {
        self.currentPhotoIndex = index;
        isScrolling = false;
        headerView.loadImage(imageURL: restaurant.restaurantImageURL(atIndex: self.currentPhotoIndex), atIndex: self.currentPhotoIndex);
    }
    
    func shouldScrollToChildView(photoIndex: Int, direction: Int) {
        let numberOfPhotos = restaurant.numberOfImages();
        if ((photoIndex == (numberOfPhotos-1))) {
            if (direction == 2) { // Means scroll to right
                if (!isScrolling) {
                    isScrolling = !isScrolling;
                    NSNotificationCenter.defaultCenter().postNotificationName(LFRestaurantContainerPresenter.MOVE_TO_NEXT_CONTROLLER_NOTIFICATION, object: nil, userInfo: nil);
                }
            }
        }
        else if (currentPhotoIndex == 0 && photoIndex == 0) {
            if (direction == 1) { // Means scroll to left
                if (!isScrolling) {
                    isScrolling = !isScrolling;
                    NSNotificationCenter.defaultCenter().postNotificationName(LFRestaurantContainerPresenter.MOVE_TO_PREV_CONTROLLER_NOTIFICATION, object: nil, userInfo: nil);
                }
            }
        }
    }
}

class LFRestaurantCardCollectionViewLayoutStrategy: LFRestaurantCardLayoutStrategy, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    /* CELLS */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("DummyCell", forIndexPath: indexPath);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 30);
    }
    
    /* HEADER */
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                                                                     withReuseIdentifier: LFScrollingHeaderReusableView.IDENTIFIER,
                                                                     forIndexPath: indexPath) as? LFScrollingHeaderReusableView {
            header.populateSubviews(nbElements: self.restaurant.numberOfImages(), width: CGRectGetWidth(collectionView.frame), height: LFScrollingHeaderReusableView.HEIGHT);
            header.presenterDelegate = self;
            return header;
        }
        return UICollectionViewCell();
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), LFScrollingHeaderReusableView.HEIGHT);
    }
    
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if let header = view as? LFScrollingHeaderReusableView {
            header.refreshHeader(title: restaurant.restaurantName(), subtitle: restaurant.restaurantAddress());
            header.loadImage(imageURL: restaurant.restaurantImageURL(atIndex: self.currentPhotoIndex), atIndex: self.currentPhotoIndex);
        }
    }
}