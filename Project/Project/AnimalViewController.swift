//
//  AnimalViewController.swift
//  Project
//
//  Created by mac033 on 6/12/24.
//

import UIKit

class AnimalViewController: UIViewController, ViewModelOutPut {
    
    public var animatype :Int = 0
    
    private enum Matrics{
        static let inset: CGFloat = 4
    }
    
    private let collectionV: UICollectionView = {
        let cvlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvlayout)
        cv.backgroundColor = .systemYellow
        cvlayout.minimumLineSpacing = Matrics.inset
        cvlayout.minimumInteritemSpacing = Matrics.inset
        return cv
    }()
    
    private let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @IBAction func closeImg(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    private func setupView(){
        self.view.addSubview(self.collectionV)
        
        self.collectionV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.collectionV.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -75)
        ])
        
        self.viewModel.attach(delegate: self)
        self.viewModel.load(animalType: self.animatype)
        self.collectionV.dataSource = self
        self.collectionV.delegate = self
        self.collectionV.register(animalCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionV.reloadData()
    }

    func loadComplete() {
        DispatchQueue.main.async {
            self.collectionV.reloadData()
        }
    }
}

extension AnimalViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        
        let cellWidth = (width - 2 * Matrics.inset) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.loadMoreImages(index: indexPath.item, type: self.animatype)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = SecondViewController(viewModel: self.viewModel, index: indexPath.item)
        secondViewController.svc_animatype = self.animatype
        self.present(secondViewController, animated: true, completion: nil)
    }
}

extension AnimalViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.imgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! animalCell
        
        //cell.backgroundColor = .black
        let data = self.viewModel.imgData[indexPath.item]
        cell.SetData(urlSting: data.url)
        return cell
    }
}


