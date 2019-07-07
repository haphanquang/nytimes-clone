//
//  Route.swift
//  NYTimesClone
//
//  Created by QH on 7/6/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class Route {
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func displayHome() {
        let home = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let viewModel = HomeViewModel()
        home.viewModel = viewModel
        
        let windows = (UIApplication.shared.delegate as? AppDelegate)?.window
        windows?.rootViewController = home
    }
    
    static func showArticleDetail(from: UIViewController, article: Article) {
        
    }
}
