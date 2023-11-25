//
//  UICollectionViewExample.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/9/23.
//

import UIKit

let collectionViewCellGap: CGFloat = 0.5

class CECollectionViewCell: UICollectionViewCell {
    
    var imageName: String
    let imageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        self.imageName = "leo"
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        addSubview(imageView)
    }
    
    func setupImage() -> Void {
        self.imageView.image = UIImage(named: imageName)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = UIColor.black
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

class UICollectionViewExample: UIViewController {
    
    let imageNames: [String] = ["leo", "mole3", "sampleImage"]
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = collectionViewCellGap
        layout.minimumLineSpacing = collectionViewCellGap
        
        let cv: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CECollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        setupView()
    }
    
    private func setupView() -> Void {
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            self.collectionView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

//Datasource
extension UICollectionViewExample: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CECollectionViewCell
        cell.imageName = imageNames[indexPath.item]
        cell.setupImage()
        return cell
    }
}

//Delegate
extension UICollectionViewExample: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let width = (self.view.frame.width / 3) - collectionViewCellGap
        return CGSize(width: width, height: width)
    }
}

#Preview {
    UICollectionViewExample()
}
