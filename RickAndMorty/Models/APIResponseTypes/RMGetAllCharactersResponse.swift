//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//

import Foundation

struct RMGetAllCharactersResponse : Codable {
    struct info : Codable {
        let count : Int
        let pages : Int
        let next : String?
        let previous : String?
        
    }
    let info : info
    let results : [RMCharacter]
    
}
