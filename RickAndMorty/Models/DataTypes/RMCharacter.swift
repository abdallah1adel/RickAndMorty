//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by pcpos on 19/04/2024.
//

import Foundation

struct RMCharacter : Codable{
  let id: Int
  let name: String
  let status: RMCharacterstatus
  let species: String
  let type: String
  let gender: RMCharactergender
  let origin: RMorigins
  let location : RMSingleLocation
let image: String
let episode : [String]
let URL : String
let created : String
    
}
