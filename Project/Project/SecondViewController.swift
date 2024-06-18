//
//  SecondViewController.swift
//  Project
//
//  Created by mac033 on 6/12/24.
//

import UIKit

class SecondViewController: UIViewController, ViewModelOutPut {
    
    public var svc_animatype :Int = 0
    
    private let collectionV: UICollectionView = {
        let cvlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvlayout)
        cv.backgroundColor = .white
        cvlayout.minimumLineSpacing = .zero
        cvlayout.minimumInteritemSpacing = .zero
        cvlayout.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        return cv
    }()
    
    private let viewModel: ViewModel
    private let index: Int
    
    init(viewModel: ViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error!! Error!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        self.view.addSubview(self.collectionV)
        
        self.collectionV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.collectionV.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
        
        self.viewModel.attach(delegate: self)
        self.viewModel.load(animalType: self.svc_animatype)
        self.collectionV.dataSource = self
        self.collectionV.delegate = self
        self.collectionV.register(animalCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionV.reloadData()
        
        self.collectionV.layoutIfNeeded()
        self.collectionV.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
        
    }

    func loadComplete() {
        DispatchQueue.main.async {
            self.collectionV.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.detach(delegate: self)
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.loadMoreImages(index: indexPath.item, type: self.svc_animatype)
    }
}

extension SecondViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.imgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! animalCell
        
        
        //cell.backgroundColor = .black
        let data = self.viewModel.imgData[indexPath.item]
        cell.SetData(urlSting: data.url, showImage: true)
        return cell
    }
    
    
}


