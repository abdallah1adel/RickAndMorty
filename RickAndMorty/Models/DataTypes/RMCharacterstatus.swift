//
//  RMCharacterstatus.swift
//  RickAndMorty
//
//  Created by pcpos on 21/04/2024.
//

import Foundation


 enum RMCharacterstatus : String , Codable {
     case alive = "Alive"
     case dead = "Dead"
     case `unkkown` = "Unkown"
    
     var text : String {
         switch self {
         case .alive,.dead: 
             return rawValue
         case .unkkown :
             return "UNknown"
         }
     }
}
