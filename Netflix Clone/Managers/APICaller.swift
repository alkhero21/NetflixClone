//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Alibek Allamzharov on 24.10.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "7a8caaa7615b4f4d49d16a8e7d784d85"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTgetData
}

class APICaller {
    static let shared = APICaller()
    
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL) \(Constants.API_KEY)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(trendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
  
        }
        task.resume()
    }
}
