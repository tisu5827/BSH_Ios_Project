//
//  ImageContents.swift
//  Project
//
//  Created by mac011 on 2024/06/13.
//

import Foundation
import UIKit

class ImageContents {
    
    static let shared = ImageContents()
    
    enum NetWork: Error {
        case NetWorkError
    }
    
    private let datacash = NSCache<NSString, UIImage>()
    
    func setImage(imgView: UIImageView, urlString: String) -> URLSessionDataTask? {
        
        if let image = datacash.object(forKey: urlString as NSString) {
            imgView.image = image
            return nil
        }
        
        return self.downImg(urlString: urlString) { [weak self]
            result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    return
                case .success(let image):
                    self.datacash.setObject(image, forKey: urlString as NSString)
                    imgView.image = image
                }
            }
        }
    }
    
    func downImg(urlString: String, completion: @escaping (Result<UIImage, NetWork>) -> Void) -> URLSessionDataTask {
        
        var url_request = URLRequest(url: URL(string: urlString)!)
        url_request.httpMethod = "GET"
        let imgTask = URLSession.shared.dataTask(with: url_request) {
            data, request, error in
        
            guard error == nil else {
                completion(.failure(.NetWorkError))
                return
            }
        
            guard let data = data else {
                completion(.failure(.NetWorkError))
                return
            }
        
            guard let image = UIImage(data: data) else {
                completion(.failure(.NetWorkError))
                return
            }
        
            completion(.success(image))
        }
        
        imgTask.resume()
        
        return imgTask
    }
}
