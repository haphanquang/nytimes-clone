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
        let width = UIScreen.main.bounds.size.width
        estimatedItemSize = CGSize(width: width, height: 20)
        minimumLineSpacing = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let width = UIScreen.main.bounds.size.width
        estimatedItemSize = CGSize(width: width, height: 20)
        minimumLineSpacing = 10
    }
}
