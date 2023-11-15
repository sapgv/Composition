//
//  VideoCell.swift
//  Composition
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import UIKit

extension VideoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell
        cell.backgroundColor = .red
//        cell.setup(model: "")
        return cell
    }
    
}

final class VideoCell: UITableViewCell {
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var wrapperView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGreen
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return collectionView
    }()
    
    private var wrapperHeightConstraint: NSLayoutConstraint?
    
    private func layout() {
        
        self.contentView.addSubview(wrapperView)
        
        self.wrapperView.addSubview(collectionView)
        
        self.wrapperView.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        self.wrapperView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.wrapperView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        self.wrapperView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        
        self.wrapperHeightConstraint = self.wrapperView.heightAnchor.constraint(equalToConstant: 200)
        self.wrapperHeightConstraint?.isActive = true
        
        self.collectionView.leadingAnchor.constraint(equalTo: self.wrapperView.leadingAnchor, constant: 2).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.wrapperView.topAnchor, constant: 2).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.wrapperView.trailingAnchor, constant: -2).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.wrapperView.bottomAnchor, constant: -2).isActive = true
        
    }
    
    func setup(post: VideoPost) {
        
        let layout = self.createLayout(post: post)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.reloadData()
        
        self.wrapperHeightConstraint?.constant = 100
        
    }
    
    let padding: CGFloat = 2
    
    /*
     2
     
     100 - 2 - 2 = 96
     
     2
     
     
     
     
     */
    private func createLayout(post: VideoPost) -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let topItem = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .fractionalHeight(1.0)))
                
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(2/3)))
                
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .absolute(200)))
            
//            topItem.contentInsets = NSDirectionalEdgeInsets(top: self.padding, leading: self.padding, bottom: self.padding, trailing: self.padding)
            

            let bottomItemInBottomGroup = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)))
                
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .absolute(100)))
            
//            bottomItemInBottomGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: self.padding, bottom: 0, trailing: self.padding)
            
            
            let bottomGroup = NSCollectionLayoutGroup.horizontal(
                
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .fractionalHeight(1.0)),
                
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1/3)),
                
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .absolute(100)),
                
                subitem: bottomItemInBottomGroup, count: 3)

//            bottomGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let nestedGroup = NSCollectionLayoutGroup.vertical(
                
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)),
                
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .absolute(500)),
                subitems: [topItem, bottomGroup])
            
//            nestedGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: self.padding, bottom: 0, trailing: self.padding)
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            return section

        }
        return layout
        
    }
    
//    private func createLayout(post: VideoPost) -> UICollectionViewLayout {
//
//        let layout = UICollectionViewCompositionalLayout {
//            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            let leadingItem = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
//                                                  heightDimension: .fractionalHeight(1.0)))
//            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: self.padding, leading: self.padding, bottom: self.padding, trailing: self.padding)
//
//            let trailingItem = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .fractionalHeight(0.3)))
//            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: self.padding, leading: self.padding, bottom: self.padding, trailing: self.padding)
//
//            let trailingGroup = NSCollectionLayoutGroup.vertical(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
//                                                  heightDimension: .fractionalHeight(1.0)),
//                subitem: trailingItem, count: 2)
//
//            let nestedGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .fractionalHeight(1.0)),
//                subitems: [leadingItem, trailingGroup])
//            let section = NSCollectionLayoutSection(group: nestedGroup)
//            return section
//
//        }
//        return layout
//
//    }
    
    
}

