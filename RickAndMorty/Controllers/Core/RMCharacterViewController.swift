//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by pcpos on 19/04/2024.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController , RMCharacterListViewDelegate{

    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
        
//        RMservies.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
//            switch result {
//            case.success(let model) :
//                print("tottal"+String(model.results.count))
//            case.failure(let error) :
//                print(String(describing: error))
//            }
//        }
        
    }//Main_function
    private func setUpView(){characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // MARK - rmCharacterListViewdelegate implemnation 
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter Character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: Character)
        let detailVC = RMCharacterDetailViewController (viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}//First_calss
