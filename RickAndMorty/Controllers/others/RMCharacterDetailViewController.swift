//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by pcpos on 16/05/2024.
//

import UIKit

/// controller to get deatils on single cell
final class RMCharacterDetailViewController: UIViewController {

    
    init(viewModel : RMCharacterDetailViewViewModel ) {
           super.init(
               nibName: nil,bundle: nil)}
       required init?(coder: NSCoder) {
           fatalError("Unspported")
       }
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    

}
