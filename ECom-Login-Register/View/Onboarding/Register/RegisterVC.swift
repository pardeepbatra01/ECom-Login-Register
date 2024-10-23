//
//  RegisterVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit
import IQKeyboardManagerSwift

class RegisterVC: UIViewController {
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var registerTableView: UITableView!

    //MARK: - VARIABLE'S
    
    var registerData = [
        RegisterModel(title: "Logo", value: ""),
        RegisterModel(title: "Name", value: ""),
        RegisterModel(title: "Email", value: ""),
        RegisterModel(title: "Password", value: ""),
        RegisterModel(title: "Confirm Password", value: ""),
        RegisterModel(title: "Submit", value: "")
    ]
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    //MARK: - FUNCTION'S
    
    private func setUpTableView() {
        let headerNib = UINib(nibName: RegisterHeaderCell.reuseIdentifier, bundle: nil)
        let cellNib = UINib(nibName: RegisterTVC.reuseIdentifier, bundle: nil)
        let submitCellNib = UINib(nibName: SubmitBtnTVC.reuseIdentifier, bundle: nil)
        
        registerTableView.register(headerNib, forCellReuseIdentifier: RegisterHeaderCell.reuseIdentifier)
        registerTableView.register(cellNib, forCellReuseIdentifier: RegisterTVC.reuseIdentifier)
        registerTableView.register(submitCellNib, forCellReuseIdentifier: SubmitBtnTVC.reuseIdentifier)
        
        registerTableView.rowHeight = UITableView.automaticDimension
        registerTableView.estimatedRowHeight = 50
        registerTableView.delegate = self
        registerTableView.dataSource = self
    }
}

    //MARK: - TABLE VIEW DATA SOURCE

extension RegisterVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = registerData[indexPath.row]
        
        if model.title == "Submit" {
            guard let cell = registerTableView.dequeueReusableCell(withIdentifier: SubmitBtnTVC.reuseIdentifier, for: indexPath) as? SubmitBtnTVC else {
                return UITableViewCell()
            }
            
            // Use weak reference in closure to avoid memory leaks
            cell.handleSubmitBtnEvent = { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)

                print("$ model:", self.registerData)
                
                if self.validateForm() {
                    self.handleSubmit()
                }
            }
            return cell
            
        } else if model.title == "Logo" {
            guard let cell = registerTableView.dequeueReusableCell(withIdentifier: RegisterHeaderCell.reuseIdentifier, for: indexPath) as? RegisterHeaderCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = registerTableView.dequeueReusableCell(withIdentifier: RegisterTVC.reuseIdentifier, for: indexPath) as? RegisterTVC else {
                return UITableViewCell()
            }
            
            // Configure cell with register data
            cell.model = registerData[indexPath.row]
            
            cell.handleTextfieldData = { [weak self] updatedText in
                guard let self = self else { return }
                self.registerData[indexPath.row].value = updatedText
                // Avoid unnecessary reloads
                self.registerTableView.reloadRows(at: [indexPath], with: .none)
            }
            
            return cell
        }
    }
}


    //MARK: - TABLE VIEW DELEGATE

extension RegisterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = registerData[indexPath.row]
        return model.title == "Submit" ? 100 : model.title == "Logo" ? self.view.frame.height * 0.3 : UITableView.automaticDimension
    }
}

    //MARK: - API CALLING

extension RegisterVC {
    private func handleSubmit() {
        view.endEditing(true)
        
        guard let name = registerData.first(where: { $0.title == "Name" })?.value,
              let email = registerData.first(where: { $0.title == "Email" })?.value,
              let password = registerData.first(where: { $0.title == "Password" })?.value,
              let confirmPassword = registerData.first(where: { $0.title == "Confirm Password" })?.value else {
            return
        }

        let viewModel = RegisterViewModel()
        viewModel.registerUser(name: name, email: email, password: password, passwordConfirmation: confirmPassword) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    // Handle success (e.g., navigate to another screen or show success message)
                    print("User registered successfully")
                    UtilityClass.shared.showToastMessage(title: "", body: "User registered successfully", theme: .success)
                    self.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    // Handle error (e.g., show an alert or error message)
                    print("Failed to register user: \(error.localizedDescription)")
                    self.showAlert(message: "Failed to register user: \(error.localizedDescription)")
                }
            }
        }
    }
}

    //MARK: - APPLY VALIDATION ON FORM

extension RegisterVC {
    private func validateForm() -> Bool {
        // Implement your validation logic here
        let name = registerData.first(where: { $0.title == "Name" })?.value ?? ""
        let email = registerData.first(where: { $0.title == "Email" })?.value ?? ""
        let password = registerData.first(where: { $0.title == "Password" })?.value ?? ""
        let confirmPassword = registerData.first(where: { $0.title == "Confirm Password" })?.value ?? ""
        
        // Example validation rules
        if name.isEmpty {
            showAlert(message: "Name is required.")
            return false
        }
        
        if !isValidEmail(email) {
            showAlert(message: "Invalid email format.")
            return false
        }
        
        if password.count < 6 {
            showAlert(message: "Password must be at least 6 characters.")
            return false
        }
        
        if password != confirmPassword {
            showAlert(message: "Passwords do not match.")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Simple email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
