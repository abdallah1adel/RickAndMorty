//
//  Extentions.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//

import Foundation

import UIKit

extension UIView {
    func addSubViews(_  views: UIView...  ){
        views.forEach({
        addSubview($0)
            
            
        })
    }
}


