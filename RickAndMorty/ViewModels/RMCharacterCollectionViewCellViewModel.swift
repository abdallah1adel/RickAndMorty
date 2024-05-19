//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//
 
import Foundation
final class RMCharacterCollectionViewCellViewModel {
 
 public let  charecterName : String
 private let  charecterStatus : RMCharacterstatus
 private let  charecterImageUrl : URL?
    
    
    //MARK - Init
    init (
        charecterName : String,
        charecterStatus : RMCharacterstatus,
        charecterImageUrl : URL?
        
    ) {
        self.charecterName = charecterName
        self.charecterStatus = charecterStatus
        self.charecterImageUrl = charecterImageUrl
    }
    
    public var characterStatusText : String {
        
        return "Status: \(charecterStatus.text)"
    }
    
    
    public func fetchImage(completion : @escaping(Result<Data,Error>)  -> Void ) {
        //Abstract to image Manger
        guard let Url = charecterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: Url)
        let task = URLSession.shared.dataTask(with: request) { Data, _, error in
            guard let data = Data , error==nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }//fetchImage public func
    
    
}//final Class
