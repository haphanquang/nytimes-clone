//
//  HomeArticlesFlowLayout.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class HomeArticlesFlowLayout : UICollectionViewFlowLayout {
    override init() {
        super.init()
//        let width = UIScreen.main.bounds.size.width
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
//        estimatedItemSize = CGSize(width: width, height: 500)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        let width = UIScreen.main.bounds.size.width
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        estimatedItemSize = CGSize(width: width, height: 500)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }

        layoutAttributes.bounds.size.width = UIScreen.main.bounds.size.width
        return layoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard scrollDirection == .vertical else { return superLayoutAttributes }
        
        let computedAttributes = superLayoutAttributes.compactMap { layoutAttribute in
            return layoutAttribute.representedElementCategory == .cell ? layoutAttributesForItem(at: layoutAttribute.indexPath) : layoutAttribute
        }
        return computedAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
