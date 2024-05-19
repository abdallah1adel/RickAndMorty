//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by pcpos on 04/05/2024.
//

import UIKit


protocol RMCharacterListViewDelegate : AnyObject {
    func rmCharacterListView(
        _ characterListView : RMCharacterListView
        ,didSelectCharacter Character : RMCharacter
    )
}

final class RMCharacterListView: UIView {
    
    public weak var delegate : RMCharacterListViewDelegate?
    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
        
    }()
    
    
    private let collectionVew : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        return collectionView
        
    }()
    
    //MARK - Init
    override init(frame:CGRect) {
        
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    //backgroundColor = .systemBlue //Remove blue
        addSubViews(spinner,collectionVew)
        addConstraint()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
}//init
    
    required init?(coder:
                   NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraint(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            
           collectionVew.topAnchor.constraint(equalTo: topAnchor),
           collectionVew.leftAnchor.constraint(equalTo: leftAnchor),
           collectionVew.rightAnchor.constraint(equalTo: rightAnchor),
           collectionVew.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])

    }
 
    private func setUpCollectionView(){
        collectionVew.dataSource = viewModel
        collectionVew.delegate = viewModel

    }
}

extension RMCharacterListView : RMCharacterListViewViewModelDelegate{
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    
    func didLoadInitialCharacters() {
        
        spinner.stopAnimating()
       collectionVew.isHidden = false
        collectionVew.reloadData() // inital fetch
       UIView.animate(withDuration: 0.4) {
       self.collectionVew.alpha = 1
                   }
    }
}
