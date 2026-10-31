//
//  NetworkManager.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 28/09/26.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init() { }
    
    
    
    func getFollowers(for username : String,page : Int,completed : @escaping(Result<[Follower],UIError>) -> Void){
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.internetIssue))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode([Follower].self, from: data)
                completed(.success(value))
            } catch {
                completed(.failure(.invalidResponse))
            }
            
           
        }
        task.resume()
    }
}
