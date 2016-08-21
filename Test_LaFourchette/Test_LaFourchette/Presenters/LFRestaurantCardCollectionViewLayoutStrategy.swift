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
        return 3;
    }
    
    /* CELLS */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.item {
            case 0:
                return collectionView.dequeueReusableCellWithReuseIdentifier(LFMenuCollectionViewCell.IDENTIFIER, forIndexPath: indexPath);
            case 1:
                return collectionView.dequeueReusableCellWithReuseIdentifier(LFRestaurantDescriptionCollectionViewCell.IDENTIFIER, forIndexPath: indexPath);
            case 2:
                return collectionView.dequeueReusableCellWithReuseIdentifier(LFRestaurantMapCollectionViewCell.IDENTIFIER, forIndexPath: indexPath);
            default: break
        }
        return UICollectionViewCell();
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.item {
            case 0:
                return CGSizeMake(CGRectGetWidth(collectionView.frame), LFMenuCollectionViewCell.HEIGHT);
            case 1:
                return CGSizeMake(CGRectGetWidth(collectionView.frame), LFRestaurantDescriptionCollectionViewCell.HEIGHT);
            case 2:
                return CGSizeMake(CGRectGetWidth(collectionView.frame), LFRestaurantMapCollectionViewCell.heightForCell());
            default: break
        }
        return CGSizeZero;
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let menuCell = cell as? LFMenuCollectionViewCell {
            menuCell.configureCell(leftTitle: NSString(format: "%d photos", self.restaurant.numberOfImages()) as String, centerTitle: "9,3", rightTitle: "Plan");
        }
        else if let descCell = cell as? LFRestaurantDescriptionCollectionViewCell {
            descCell.configureCell(title: self.restaurant.restaurantDescription());
        }
        else if let mapCell = cell as? LFRestaurantMapCollectionViewCell {
            
        }
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