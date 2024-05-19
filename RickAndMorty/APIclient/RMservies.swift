//
//  RMservies.swift
//  RickAndMorty
//
//  Created by pcpos on 21/04/2024.
//

import Foundation


/// primary servece API obect to get Rick and Morty data
final class RMservies{
    
    /// shared  singelton instance
    static let shared = RMservies()
    
    
    /// privatized constructor
    private init(){}
    
    enum RMserviceError : Error {
        case failedtocreatrequest
        case faildtogetData
       
    }
    
    /// calling the API 
    /// - Parameters:
    ///   - reques: request instance
    ///   - type: the type of request we expect to get back
    ///   - compleetion: call back with data or give eroor
    ///   - request: request instance
    ///   - completion: completion instance
    public func execute<T:Codable>(_ request : RMrequest,
                                   expecting type: T.Type,
                        completion: @escaping (Result<T ,Error > )-> Void){
        
        guard let urlrequest = self.request(from: request) else {
            completion(.failure(RMserviceError.failedtocreatrequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlrequest) { data, _, error in
            guard let data = data , error == nil else {
                completion(.failure(error ?? RMserviceError.faildtogetData ))
                return
            }
            
            //decode a response
            do{
                let result = try
                JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
               
            }
            catch {
                        completion(.failure(error))
            }
        }
                           task.resume()
    }
    private func request(from rmRequest:RMrequest) -> URLRequest? {
        guard let url = rmRequest.Url else { return nil}
        var request = URLRequest(url: url)
        
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}//class


/*let request = RMrequest(
 endpoint: .charcter
 queryparameters: [
 URLQueryItem(name: "name", value: "Rick")
 URLQueryItem(name: "status", value: "alive")
 ]

)
print(request.Url)*/
