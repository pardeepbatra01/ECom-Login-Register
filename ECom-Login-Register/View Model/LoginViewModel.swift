//
//  LoginViewModel.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//
import Foundation
import Combine

enum LoginError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case serverError(statusCode: Int)
}

class LoginViewModel {

    func login<T: Codable>(email: String, password: String, responseType: T.Type) -> AnyPublisher<T, LoginError> {
        guard let url = URL(string: "https://mock-api.binaryboxtuts.com/api/login") else {
            return Fail(error: LoginError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("binarybox_api_key_VzO8M31mfzUAW58MBuDkyVX68IWufWJWW7m5BqqSi3FSXHHwKeHjuXQzOC7QdACzffplQ93npFb6Q3sMQLeImXxkz3IHQDkWy1yt", forHTTPHeaderField: "X-Binarybox-Api-Key")

        let loginPayload: [String: Any] = [
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginPayload, options: .fragmentsAllowed)
        } catch {
            return Fail(error: LoginError.decodingError).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ in LoginError.requestFailed }
            .flatMap { data, response -> AnyPublisher<T, LoginError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: LoginError.requestFailed).eraseToAnyPublisher()
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    return Fail(error: LoginError.serverError(statusCode: httpResponse.statusCode)).eraseToAnyPublisher()
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    return Just(decodedResponse).setFailureType(to: LoginError.self).eraseToAnyPublisher()
                } catch {
                    return Fail(error: LoginError.decodingError).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}



