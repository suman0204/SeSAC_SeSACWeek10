//
//  Network.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    // "고래밥" : String 타입 / String: String.Type 타입
    
    func request<T: Decodable>(type: T.Type, api: SeSACAPI, completion: @escaping (Result<T, SeSACError>) -> Void) { // Result Type
                
        // parmeters는 기본적으로 http body 영역으로 들어간다, query로 들어가기 위해 Encoding 작업 필요
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString) ,headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case.failure(_):
//                guard let statusCode = response.response?.statusCode else { return }
                let statusCode = response.response?.statusCode ?? 500 // 위의 코드를 이렇게 대응해볼 수도 있다
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
        
    }
}
