//
//  RegisterTVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//
import UIKit

class RegisterTVC: UITableViewCell, UITextFieldDelegate {

    //MARK: - IBOUTLET
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    
    //MARK: - VARIABLE'S
    
    var handleTextfieldData: ((String) -> Void)?
    static let reuseIdentifier = "RegisterTVC"
    
    var model: RegisterModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            valueField.placeholder = "Enter " + model.title
            valueField.text = model.value
            setUpUI()
        }
    }
    
    //MARK: - NIB CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initial setup if needed
        valueField.delegate = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reset() // Ensure fields are reset when the cell is reused
    }
    
    //MARK: - FUNCTION'S
    
    private func setUpUI() {
        guard let data = model else { return }
        if data.title == "Email" {
            valueField.keyboardType = .emailAddress
        } else if data.title == "Password" || data.title == "Confirm Password" {
            valueField.isSecureTextEntry = true
        }
        self.selectionStyle = .none
    }

    private func reset() {
        valueField.text = ""
        valueField.isSecureTextEntry = false
        valueField.keyboardType = .default
        valueField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleTextfieldData?(textField.text ?? "")
    }
}
