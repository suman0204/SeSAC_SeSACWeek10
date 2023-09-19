//
//  SeSACAPI.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        <#code#>
    }
    
    
}

enum SeSACAPI {
    private static let key = "yKKYRfNAo0KKWFXJ2bVL6n0Xt9otrpBJtLt6cnCnhEc"
    
    case search(query: String)
    case random
    case photo(id: String) //연관값, associated value
    
    private var baseURL: String { // 항상 baseURL이 고정이 아닐 수 있다, case 별로 다르게 대응해볼 수 있다
        return "https://api.unsplash.com/"
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String : String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo: //photo의 매개변수는 여기서 사용하지 않기 때문에 생략한다
            return ["" : ""]
        }
    }
    
}
