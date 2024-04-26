//
//  NetworkManager.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import Foundation

/**
 3.1 Create a protocol called `NetworkManagerDelegate` that contains a function called `usersRetrieved`.. This function should accept an array of `User` and should not return anything.
 */
//protocol NetworkManagerDelegate {
//    func usersRetrieved(_ users:[User])
//}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://reqres.in/api/"
    
    private init() {}
  
//    var delegate : NetworkManagerDelegate?
    
    func getUsers(completion: @escaping (Result<[User], DMError>) -> Void) {
        
        let completeURL = baseUrl + "users"
        
        
        guard let url = URL(string: completeURL) else{
            completion(.failure(.invalidURL))
            return
        }
        
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }

                
                
            guard let data = data else{
                completion(.failure(.invalidData))
                return
            }
           
            
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
               // calls .self on UserResponse to convert the struct into a type becuz thats what .decode needs as a parameter and the second is just the data
                let userResponse = try decoder.decode(UserResponse.self, from: data)
                // .decode has an output  - an object of decoded data which i set to userResponse
                completion(.success(userResponse.data))
                
//                
//                DispatchQueue.main.async {
//                    self.delegate?.usersRetrieved(userResponse.data)
//                }
               
                
                
                
            } catch {
                print("There was an error in the decoding!")
                completion(.failure(.invalidData))
                
            }
        }
        
        task.resume()
    }
}
