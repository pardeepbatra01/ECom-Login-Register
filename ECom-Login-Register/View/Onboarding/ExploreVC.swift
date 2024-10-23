//
//  ExploreVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//
import UIKit

class ExploreVC: UIViewController {
    
    // MARK: - UI Elements (Lazy Loaded)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Online shopping")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore the app"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi \
        maecenas quis interdum enim enim molestie faucibus. Pretium non \
        massa eros, nunc, urna. Ac laoreet sagittis donec vel.
        """
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's Start", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    deinit {
        print("\(self) deallocated")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
        
        // Add layout constraints here
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Layout for imageView
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            // Layout for titleLabel
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Layout for descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Layout for startButton
            startButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Button Actions
    @objc private func startButtonTapped() {
        // Weak self reference inside closures to avoid retain cycles
        let loginVC = LoginVC()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

