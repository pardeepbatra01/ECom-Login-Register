//
//  SubmitBtnTVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit

class SubmitBtnTVC: UITableViewCell {
    
    @IBOutlet weak var submitBtn: UIButton!
    
    // MARK: - Constants
    
    static let reuseIdentifier = "SubmitBtnTVC"
    
    // MARK: - Variables
    
    var handleSubmitBtnEvent: (() -> Void)?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setUpUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset any state or properties if necessary
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        submitBtn.layer.cornerRadius = 7
        // Additional UI setup if needed
    }
    
    // MARK: - Actions
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        handleSubmitBtnEvent?()
    }
}
