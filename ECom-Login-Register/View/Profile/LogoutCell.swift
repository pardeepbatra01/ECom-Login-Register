//
//  LogoutCell.swift
//  Demo
//
//  Created by Sushil Chaudhary on 14/09/24.
//

import UIKit

class LogoutCell: UICollectionViewCell {
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    //MARK: - VARIABLE'S
    
    static let reuseIdentifier = "LogoutCell"
    // Use weak self in the closure to avoid retain cycles
    var logoutCompletion: (() -> Void)?

    //MARK: - NIB CYCLE'S
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Style the button
        logoutBtn.layer.cornerRadius = 7
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Clear any potential state here if necessary
        logoutCompletion = nil
    }
    
    //MARK: - IBACTION'S
    
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        // Safely call the completion handler if it exists
        logoutCompletion?()
    }
}

