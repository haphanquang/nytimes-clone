//
//  SearchHistoriesViewController.swift
//  NYTimesClone
//
//  Created by QH on 7/8/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class SearchHistoriesViewController : BaseViewController<SearchHistoriesViewModel> {
    @IBOutlet weak var tblTerms: UITableView!
    
    var onSelectedKeyword: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadKeywords()
    }
    
    override func setupUI() {
        super.setupUI()
        tblTerms.delegate = self
        tblTerms.dataSource = self
    }
    
    override func setupViewModel() {
        viewModel.onStateReloaded = { [weak self] in
            self?.tblTerms.reloadData()
        }
    }

    
}

extension SearchHistoriesViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.keywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        cell.textLabel?.text = viewModel.keywords[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectedKeyword?(viewModel.keywords[indexPath.row])
    }
}
