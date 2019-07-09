//
//  UpdatingCell.swift
//  NYTimesClone
//
//  Created by QH on 7/8/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class UpdatingCell : UICollectionViewCell {
    static let identifier: String = "UpdatingCell"

    @IBOutlet weak var lblUpdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        
        contentView.backgroundColor = UIColor.clear
        lblUpdate.textColor = UIColor.darkGray
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: UIScreen.main.bounds.size.width, height: 1))
    }
}
