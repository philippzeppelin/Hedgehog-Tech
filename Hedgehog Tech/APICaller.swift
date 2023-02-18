//
//  APICaller.swift
//  Hedgehog Tech
//
//  Created by Philipp Zeppelin on 17.02.2023.
//

import UIKit

class APICaller {
    static let shared = APICaller()
    var searchText = ""
    
    struct Constats {

        static let topHeadlinesURL = URL(string: "https://serpapi.com/search.json?tbm=isch&ijn=0&q=Apple")
    }
    
    func getImages(completion: @escaping (Result<[Images], Error>) -> Void) {
        guard let url = Constats.topHeadlinesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponce.self, from: data)
                    completion(.success(result.images_results))
                    
                    print(result.images_results.count)
                    completion(.success(result.images_results))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
