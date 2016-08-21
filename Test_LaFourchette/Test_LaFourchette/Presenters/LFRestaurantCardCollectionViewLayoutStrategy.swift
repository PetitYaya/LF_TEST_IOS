//
//  LFRestaurantCardCollectionViewLayoutStrategy.swift
//  Test_LaFourchette
//
//  Created by Yacine on 21/08/2016.
//  Copyright © 2016 Yacine. All rights reserved.
//

import UIKit

class LFRestaurantCardLayoutStrategy: NSObject {

    internal var restaurant : LFRestaurantDataInterface!;

    // MARK: Constructor
    init(dataInterface: LFRestaurantDataInterface) {
        super.init();
        self.restaurant = dataInterface;
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
            header.populateSubviews(width: CGRectGetWidth(collectionView.frame), height: LFScrollingHeaderReusableView.HEIGHT);
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
        }
    }

}