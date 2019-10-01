//
//  ImageManager.swift
//  Save_lab
//
//  Created by EricM on 9/30/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    private init() {}
    static let shared = ImageHelper()

    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> Void) {

        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            guard error == nil else {
                completionHandler(.failure(.badURL))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            completionHandler(.success(image))
            

            }.resume()
    }
}
