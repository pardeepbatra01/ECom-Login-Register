//
//  ViewController.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit
import SwiftMessages
import Combine

class LoginVC: UIViewController {

    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    

    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Mini Shop"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email ID"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        setupUI()
    }
    
    deinit {
        print("\(self) Login deallocated")
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        
        // Add background image view to the main view
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Add scroll view and content view
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Add UI elements inside the content view
        contentView.addSubview(logoLabel)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        loginButton.addSubview(activityIndicator)
        contentView.addSubview(createButton)

        // Set constraints for UI elements
        setupConstraints()
    }

    private func setupConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            welcomeLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),

            createButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            createButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func toggleLoginButton(isLoading: Bool) {
        if isLoading {
            loginButton.setTitle("", for: .normal)
            activityIndicator.startAnimating()
            loginButton.isEnabled = false
        } else {
            loginButton.setTitle("Login", for: .normal)
            activityIndicator.stopAnimating()
            loginButton.isEnabled = true
        }
    }
    
    private func navigateToHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabVC = storyboard.instantiateViewController(identifier: "TabVC") as? TabVC {
            navigationController?.pushViewController(tabVC, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {
        loginApi()
    }
    
    @objc private func createButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC {
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}

//MARK: - EXTENSIONS (API Calling)

extension LoginVC {
    private func loginApi() {
        guard validateFields() else { return }
        toggleLoginButton(isLoading: true)
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let viewModel = LoginViewModel()
        viewModel.login(email: email, password: password, responseType: LoginResponse.self)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.toggleLoginButton(isLoading: false)
                    
                    switch completion {
                    case .finished:
                        // Successful completion
                        break
                    case .failure(let error):
                        // Handle error
                        print("Error logging in: \(error.localizedDescription)")
                        UtilityClass.shared.showToastMessage(title: "", body: "\(error.localizedDescription)", theme: .error)
                    }
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    print("Login successful!")
                    self?.store(data: response, forKey: "user_info")
                    self?.navigateToHomePage()
                }
            })
            .store(in: &cancellables)
    }
    
    
    private func validateFields() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password")
            return false
        }
        return true
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Helper Methods

extension LoginVC {
    func store<T: Codable>(data: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            print("Failed to encode data: \(error)")
        }
    }
}
