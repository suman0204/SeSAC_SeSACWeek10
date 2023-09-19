//
//  BeerAPI.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import Foundation
import Alamofire

enum BeerAPI {
    private static var key = "" // 키가 있다면
    
    case beers
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/"
    }
    
    var endPoint: URL {
        switch self {
        case .beers:
            return URL(string: baseURL + "beers")!
        case .singleBeer:
            return URL(string: baseURL + "beers/1")!
        case .randomBeer:
            return URL(string: baseURL + "beers/random")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders { // headers가 필요하다면..
        return ["dsdf" : "fdsf"]
    }
}
