//
//  ProfileVC.swift
//  Demo
//
//  Created by Sushil Chaudhary on 14/09/24.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: - VARIABLE'S
    
    private var collectionView: UICollectionView!
    private var data: LoginResponse?

    //MARK: - VIEW LIFE CYCLE'S
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        setupCollectionView()
        loadData()
    }
    
    //MARK: - FUNCTION'S
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: ProfileCVC.reuseIdentifier, bundle: nil)
        let logoutNib = UINib(nibName: LogoutCell.reuseIdentifier, bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: ProfileCVC.reuseIdentifier)
        collectionView.register(logoutNib, forCellWithReuseIdentifier: LogoutCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            return section
        }
    }
    
    private func loadData() {
        if let userData = retrieve(forKey: "user_info", as: LoginResponse.self) {
            self.data = userData
            collectionView.reloadData()
        }
    }
    
}

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCVC.reuseIdentifier, for: indexPath) as! ProfileCVC
            cell.configure(with: "Name: \(self.data?.user.name ?? "")", fontSize: 19, weight: .medium)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCVC.reuseIdentifier, for: indexPath) as! ProfileCVC
            cell.configure(with: "Id: \(self.data?.user.id ?? 0)", fontSize: 17, weight: .medium)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCVC.reuseIdentifier, for: indexPath) as! ProfileCVC
            cell.configure(with: "Email: \(self.data?.user.email ?? "")", fontSize: 15, weight: .medium)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogoutCell.reuseIdentifier, for: indexPath) as! LogoutCell
            cell.logoutCompletion = { [weak self] in
                self?.showLogoutAlert()
            }
            return cell
        }
    }
}

extension ProfileVC {
    
    private func showLogoutAlert() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.remove(forKey: "user_info")
            self?.navigateToLoginPage()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
    
        present(alertController, animated: true, completion: nil)
    }
    
    private func navigateToLoginPage() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
           let window = appDelegate.window {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
            window.rootViewController = UINavigationController(rootViewController: loginVC)
            window.makeKeyAndVisible()
        }
    }
}

    //MARK: - HELPER METHODS

extension ProfileVC {
    func retrieve<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            print("No data found for key: \(key)")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode data: \(error)")
            return nil
        }
    }
    
    func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
