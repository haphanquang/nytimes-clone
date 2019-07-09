//
//  LoadMoreCell.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class LoadMoreCell : UICollectionViewCell {
    static let identifier: String = "LoadMoreCell"

    @IBOutlet weak var indicator: UIActivityIndicatorView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        indicator.hidesWhenStopped = true
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: UIScreen.main.bounds.size.width, height: 1))
    }
}
