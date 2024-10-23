//
//  TabVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 14/09/24.
//

import UIKit

class TabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.selectedIndex = 2
    }

}
