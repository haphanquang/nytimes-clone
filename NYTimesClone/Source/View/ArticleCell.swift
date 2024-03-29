//
//  ArticleCell.swift
//  NYTimesClone
//
//  Created by QH on 7/5/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UICollectionViewCell {
    static let identifier = "ArticleCell"
    
    var viewModel: ArticleCellViewModel! {
        didSet {
            if viewModel != nil {
                refresh()
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var stackContent: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
        width.constant = UIScreen.main.bounds.width
    }
    
    private func refresh() {
//        imageView.setImage(viewModel.image ?? "", placeHolder: nil, completion: nil)
        lblAuthor.text = viewModel.author
        lblHeadline.text = viewModel.title
        lblContent.text = viewModel.desription
        lblTime.text = viewModel.time?.timeAgo
    }
    
    
    lazy var width: NSLayoutConstraint = {
        let width = stackContent.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        width.priority = UILayoutPriority.required
        return width
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: UIScreen.main.bounds.size.width, height: 1))
    }
}
