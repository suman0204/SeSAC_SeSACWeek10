//
//  BeerNetwork.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import Foundation
import Alamofire

final class BeerNetwork {
    
    static let shared = BeerNetwork()
    
    private init() { }
    
    func request<T: Decodable>(type: T.Type, api: BeerAPI, completionHandler: @escaping (Result<T, SeSACError>) -> Void ) {
        AF.request(api.endPoint, method: api.method).responseDecodable(of: T.self) { response in
            switch response.result {
            case.success(let result):
                completionHandler(.success(result))
            case.failure(_):
                let stausCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: stausCode) else {
                    return
                }
                completionHandler(.failure(error))
            }
        }
    }
    
    func requestBeers(completionHandler: @escaping (Beer?, Error?) -> Void ) {
        let url = BeerAPI.beers.endPoint
        
        AF.request(url, method: .get).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let result):
                dump(result)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func requestSingleBeer(completionHandler: @escaping (Beer?, Error?) -> Void ) {
        let url = BeerAPI.singleBeer.endPoint
        
        AF.request(url, method: .get).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let result):
                dump(result)
            case.failure(let error):
                print(error)
            }
        }
    }
}
