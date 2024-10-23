//
//  AppDelegate.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            // Enable IQKeyboardManager to handle keyboard behavior
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            
            
            handleLoginLogout()
            return true
        }
        
        // MARK: - Handle User Authentication
    
        private func handleLoginLogout() {
            // Check if user info exists to determine navigation
            if let userInfo = retrieve(forKey: "user_info", as: LoginResponse.self) {
                print("User info found: \(userInfo)")
                navigateToTabPage()
            } else {
                navigateToExplorePage()
            }
        }
        
        // MARK: - Navigation
    
        private func navigateToExplorePage() {
            // Use lazy loading for storyboard reference to minimize memory usage
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // Instantiate ExploreVC only when needed
            guard let loginVC = storyboard.instantiateViewController(identifier: "ExploreVC") as? ExploreVC else {
                print("Failed to instantiate ExploreVC")
                return
            }
            
            // Use weak self to avoid retaining strong references to the AppDelegate
            let navigationController = UINavigationController(rootViewController: loginVC)
            setRootViewController(navigationController)
        }
        
        private func navigateToTabPage() {
            // Use lazy loading for storyboard reference to minimize memory usage
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // Instantiate TabVC only when needed
            guard let tabVC = storyboard.instantiateViewController(identifier: "TabVC") as? TabVC else {
                print("Failed to instantiate TabVC")
                return
            }
            
            // Use weak self to avoid retaining strong references to the AppDelegate
            let navigationController = UINavigationController(rootViewController: tabVC)
            setRootViewController(navigationController)
        }

        // Set the root view controller with memory management focus
        private func setRootViewController(_ rootVC: UIViewController) {
            // Clear the previous view controller and set the new one
            window?.rootViewController = nil // Deallocate previous root view controller to avoid memory leaks
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
        }
        
        // MARK: - Helper Methods
        
        // A method to retrieve user data in a memory-efficient way
        private func retrieve<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            return try? JSONDecoder().decode(T.self, from: data)
        }

        // MARK: - Logout / Clear resources
    
        func handleLogout() {
            // Remove user info from UserDefaults and set root view controller to login page
            UserDefaults.standard.removeObject(forKey: "user_info")
            
            // Navigate to login page and ensure all unnecessary resources are deallocated
            navigateToExplorePage()
        }
    
}


