//
//  RMrequest.swift
//  RickAndMorty
//
//  Created by pcpos on 21/04/2024.
//

import Foundation

/// object that represent a single API call
/// constructed url for the API request in string format
final class RMrequest{
    /// API constant
    private struct constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// desired endpoint
    private let endpoint : RMEndPoint
    /// path compontants if any
     private let pathcompontants : [String]
    /// uery argument if any
     private let queryparameters : [URLQueryItem]
    /// Constructed url for the api request in string format
    private var UrlString : String {
        var string = constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathcompontants.isEmpty {
            pathcompontants.forEach({
                string += "/\($0)"
            })
            
        }//if path
        if !queryparameters.isEmpty {
            string += "?"
            let argumentString = queryparameters.compactMap({
                guard let value = $0.value else {
                    return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
            }
            
        
        return string
        
    }
    
    /// computed and constraucted url
    public var Url : URL? {
        return URL(string: UrlString)
    }
    
    /// desired http method
    public let httpMethod = "GET"
    
     public init
    (endpoint: RMEndPoint ,
     pathcomonents: [String] = [],
     queryparameters: [URLQueryItem] = [] )
    {
        self.endpoint = endpoint
        self.pathcompontants = pathcomonents
        self.queryparameters = queryparameters
        
        
        
        
    }
    
    }//class
extension RMrequest{
    static let liatCharactersRequests = RMrequest(endpoint: .charcter)
}
