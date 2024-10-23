//
//  RegisterViewModel.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import Foundation

class RegisterViewModel {
    
    // Method for registering user
    func registerUser(name: String, email: String, password: String, passwordConfirmation: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Define the URL for the API
        guard let url = URL(string: "https://mock-api.binaryboxtuts.com/api/register") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("binarybox_api_key_VzO8M31mfzUAW58MBuDkyVX68IWufWJWW7m5BqqSi3FSXHHwKeHjuXQzOC7QdACzffplQ93npFb6Q3sMQLeImXxkz3IHQDkWy1yt", forHTTPHeaderField: "X-Binarybox-Api-Key")
        
        // Create the JSON body
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(error))
                return
            }
            
            // Handle successful response
            completion(.success(()))
        }
        
        task.resume()
    }
}
