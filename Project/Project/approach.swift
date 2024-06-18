//
//  approach.swift
//  Project
//
//  Created by mac033 on 6/12/24.
//

import Foundation

struct InResponse: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}
final class approach {
    
    enum RequestError: Error {
        case networkError
    }
    
    func getImages(
        imgpage: Int,
        limits: Int,
        type: Int,
        completion: @escaping (Result<[InResponse], RequestError>) -> Void
    
    ) {
        print(type)
        var datafollow = URLComponents(string: "https://api.thecatapi.com/v1/images/search")!
        
        if(type == 1){
            datafollow = URLComponents(string: "https://api.thedogapi.com/v1/images/search")!
        }
        datafollow.queryItems = [
            URLQueryItem(name: "page", value: "\(imgpage)"),
            URLQueryItem(name: "limits", value: "\(limits)")
        ]
        
        var request = URLRequest(url: datafollow.url!)
        request.httpMethod = "GET"
        
        let imgTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard error == nil else {
                
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = try?
                    JSONDecoder().decode([InResponse].self, from: data)
            else {
                completion(.failure(.networkError))
                return
            }
            print(response)
            
            completion(.success(response))
        }
        imgTask.resume()
        
        
    }
}
