//
//  DetailViewModel.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

struct DetailViewModel : BasicViewModel {
    var onStateReloaded: (() -> ())?
    var onStartWaiting: (() -> ())?
    var onFinishWaiting: (() -> ())?
    
}
