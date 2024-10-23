//
//  RegisterHeaderCell.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit

class RegisterHeaderCell: UITableViewCell {

    //MARK: - VARIABLE'S
    
    static let reuseIdentifier = "RegisterHeaderCell"
    
    //MARK: - NIB CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

