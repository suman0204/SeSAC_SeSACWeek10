//
//  NetworkBasic.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACError: Int, Error, LocalizedError {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증 정보가 없습니다"
        case .permissionDenied:
            return "권한이 없습니다"
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요"
        }
    }
}

final class NetworkBasic { //상속할거 아니라서 final - 컴파일 타임에서의 성능, dispatch / 유지 보수 측면에도 있다
    
    static let shared = NetworkBasic()
    
    private init() { } // 외부에서 초기화하지 못하게 private로 초기화막는다
    
//    func request(query: String, completion: @escaping (Photo?,Error?) -> Void) {  //search Photo request
    func request(api: SeSACAPI, query: String, completion: @escaping (Result<Photo,SeSACError>) -> Void) { // Result Type
        
//        let api = SeSACAPI.search(query: query)
        
        // parmeters는 기본적으로 http body 영역으로 들어간다, query로 들어가기 위해 Encoding 작업 필요
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString) ,headers: api.header).responseDecodable(of: Photo.self) { response in
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
    
    
    func random(api: SeSACAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void ) {  //random Photo request
        
        AF.request(api.endPoint, method: api.method ,headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            case .success(let data): dump(data)
            case.failure(_):
                let statusCode = response.response?.statusCode ?? 500 // 위의 코드를 이렇게 대응해볼 수도 있다
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
        
    }
    
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        
//        let api = SeSACAPI.photo(id: id)
        
        AF.request(api.endPoint, method: api.method ,headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            case .success(let data): completion(.success(data))
            case.failure(_):
                let statusCode = response.response?.statusCode ?? 500 // 위의 코드를 이렇게 대응해볼 수도 있다
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
}
