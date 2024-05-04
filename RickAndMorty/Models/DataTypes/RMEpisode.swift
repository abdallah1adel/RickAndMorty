//
//  RMEpisodes.swift
//  RickAndMorty
//
//  Created by pcpos on 19/04/2024.
//

import Foundation

struct RMEpisode : Codable {
    
    let id : Int
    let name : String
    let ari_date : String
    let episode : String
    let URL : String
    let created  : String
    let characters : [String]
}
