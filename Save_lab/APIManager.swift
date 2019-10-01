//
//  APIManager.swift
//  Save_lab
//
//  Created by EricM on 9/30/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

struct Image: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String
    let tags: String
    let user: String
    let likes: Int 
}

final class APIManager {
    
    private init() {}
    
    static let manager = APIManager()
    
    func getImage(search: String ,completionHandler: @escaping (Result<[Hit], AppError>) -> () ) {
        
        //let searchNameForatted = search.replacingOccurrences(of: " ", with: "-")
        
        let stringURL = "https://pixabay.com/api/?key=\(Secret.apiKey)&q=\(search)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get, completionHandler: { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let imageData = try JSONDecoder().decode(Image.self, from: data)
                    completionHandler(.success(imageData.hits ))
                } catch {
                    print(error)
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        })
    }
}
