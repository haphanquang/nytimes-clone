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
        
        let nav = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? UINavigationController
        nav?.viewControllers = [home]
    }
    
    static func createSearchTerm() -> SearchHistoriesViewController {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SearchHistoriesViewController") as! SearchHistoriesViewController
        
        let viewModel = SearchHistoriesViewModel()
        vc.viewModel = viewModel
        return vc
    }
    
    static func showArticleDetail(from: UIViewController, article: Article) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        var viewModel = DetailViewModel()
        viewModel.detailArticle = article
        vc.viewModel = viewModel
        
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
