//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//

import Foundation
import UIKit


protocol RMCharacterListViewViewModelDelegate : AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character:RMCharacter)
}

final class RMCharacterListViewViewModel : NSObject {
    
    public weak var delegate : RMCharacterListViewViewModelDelegate?
    
    private var characters : [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(charecterName: character.name,
                                                                       charecterStatus: character.status,
                                                                       charecterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    private var cellViewModels : [RMCharacterCollectionViewCellViewModel] = []
    public func fetchCharacters(){
        RMservies.shared.execute(
            .listCharactersRequests,
            expecting: RMGetAllCharactersResponse.self)
        { [weak self] result in
            switch result {
            case.success(let responsemodel) :
                let results = responsemodel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case.failure(let error) :
                print (String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath)
                //cell.backgroundColor = .systemGreen
                as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}
