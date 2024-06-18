//
//  ViewModel.swift
//  Project
//
//  Created by mac011 on 2024/06/13.
//

import Foundation


protocol ViewModelOutPut: AnyObject{
    func loadComplete()
}

final class ViewModel {
    
    private let imgApproach = approach()
    
    private var limit = 3*7
    private var Page_current = 0
    
    weak var delegate: ViewModelOutPut?
    private var delegates: [ViewModelOutPut] = []
    
    var imgData: [InResponse] = []
    
    func attach(delegate: ViewModelOutPut) {
        self.delegates.append(delegate)
    }
    
    func detach(delegate: ViewModelOutPut) {
        self.delegates = self.delegates.filter {
            $0 !== delegate
        }
    }
    
    var isLoading: Bool = false
    
    func load(animalType: Int) {
        
        guard !isLoading else { return }
        self.isLoading = true
        
        self.imgApproach.getImages(imgpage: self.Page_current, limits: self.limit, type: animalType) {
            result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    break
                case .success(let response):
                    self.imgData.append(contentsOf: response)
                    self.Page_current += 1
                    self.delegates.forEach{ $0.loadComplete()}
                }
                
                self.isLoading = false
            }
            
        }
    }
    
    func loadMoreImages(index: Int, type: Int){
        if index > imgData.count - 6 {
            self.load(animalType: type)
        }
    }
    
}
