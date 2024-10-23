//
//  ProfileCVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 14/09/24.
//

import UIKit

class ProfileCVC: UICollectionViewCell {
    
//MARK: - IBOUTLET'S
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - VARIABLE'S
    
    static let reuseIdentifier = "ProfileCVC"
    
    //MARK: - FUNCTION'S
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configure(with text: String, fontSize: CGFloat, weight: UIFont.Weight) {
        titleLabel.text = text
        titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
}

