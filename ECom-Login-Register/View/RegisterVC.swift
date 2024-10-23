//
//  RegisterVC.swift
//  WorksDelightDemo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit
import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
