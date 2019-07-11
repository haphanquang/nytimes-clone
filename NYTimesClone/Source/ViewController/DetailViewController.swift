//
//  DetailViewController.swift
//  NYTimesClone
//
//  Created by QH on 7/6/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : BaseViewController <DetailViewModel> {
    
    @IBOutlet weak var tblDetail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadDetail()
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
}

