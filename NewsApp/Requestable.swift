//
//  Requestable.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation

public enum Result<Value: Decodable> {
    case success(Value)
    case failure(Value)
}

public typealias Handler = (Result<Data>) -> Void

public protocol Requestable {}

extension Requestable {
    func request(urlString: String,
                 method: String,
                 completion: @escaping Handler) {
        // Create a URL object from the string
        guard let urls = URL(string: urlString) else {
            return
        }

        // Create a URLSession configuration
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: urls)
        request.httpMethod = method
        
        // Create a data task with the GET method
        let task = session.dataTask(with: urls) { (data, response, error) in
            // Check for errors
            if let error = error {
                print(error.localizedDescription)
            }

            // Check if data is available
            guard let data = data else {
                print("No Data")
                return
            }
            
            // Successful response
            completion(.success(data))
        }

        // Start the data task
        task.resume()
    }
}
