//
//  BaseViewController.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController <T: BasicViewModel> : UIViewController {
    
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalized()
        setupViewModel()
    }
    
    func setupUI() {
        
    }
    
    func setupLocalized() {
        
    }
    
    func setupViewModel() {
        viewModel.onStartWaiting = { [weak self] in
            guard let `self` = self else { return }
            self.beginLoading()
        }
        
        viewModel.onFinishWaiting = { [weak self] in
            guard let `self` = self else { return }
            self.finishLoading()
        }
    }
    
    func beginLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func displayNetworkError() {
        
    }
}
