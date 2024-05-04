//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//

import UIKit

/// view that handles shwoing list of characters oaders etc
final class RMCharacterListView: UIView {
    
    
    private let viewModel = RMCharacterListViewViewModel()
    /// replaced let with var HE MADE IT LET
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style : .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
                              top: 0,
                              left: 10,
                              bottom: 0,
                              right: 10)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(collectionView, spinner)
        addConstraint()
        spinner.startAnimating()
        viewModel.fetchCharacters()
        setUpCollectionView()
        // backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private  func addConstraint() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo:safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        })
    }
}
