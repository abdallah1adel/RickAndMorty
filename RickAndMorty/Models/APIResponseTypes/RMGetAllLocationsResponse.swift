//
//  RMGetAllLocationsResponse.swift
//  RickAndMorty
//
//  Created by pcpos on 29/01/2025.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMLocation]
}
