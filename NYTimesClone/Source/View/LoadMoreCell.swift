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
        indicator.hidesWhenStopped = true
    }
}
