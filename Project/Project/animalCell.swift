//
//  animalCell.swift
//  Project
//
//  Created by mac033 on 6/12/24.
//

import UIKit
import Foundation

final class animalCell: UICollectionViewCell{
    
    private let animalImg = UIImageView()
    private var dataTask: URLSessionDataTask?
    private let imageShared = ImageContents.shared
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    private func setupView() {
        self.addSubview(self.animalImg)
        
        self.animalImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.animalImg.topAnchor.constraint(equalTo: self.topAnchor),
            self.animalImg.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.animalImg.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.animalImg.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        self.animalImg.contentMode = .scaleAspectFill
        self.animalImg.clipsToBounds = true
    }
    
    func SetData(urlSting: String, showImage: Bool = false) {
        dataTask?.cancel()
        self.animalImg.image = nil
        if showImage {
            self.animalImg.contentMode = .scaleAspectFit
        }
        dataTask = imageShared.setImage(imgView: self.animalImg, urlString: urlSting)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error!! Error!!")
    }
    

}
