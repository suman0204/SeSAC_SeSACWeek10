//
//  ViewController.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import UIKit
//import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
//        NetworkBasic.shared.random { photo, error in
            // 기존 방식으로 옵셔널값을 받아올 수 있으면 바인딩 작업이 필요함
//            guard let photo = photo else { return }
//            guard let photo = photo, let error = error else { return } // 바보같은 guard문이 등장할 수 있다 (photo와 error가 둘 다 값이 있을 수 없다) -> if문으로 대응
//        }
        
//        Network.shared.request(type: Photo.self, api: .search(query: "apple")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case.failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
        
        Network.shared.request(type: PhotoResult.self, api: .photo(id: "Pcsom1UtN2c")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case.failure(let failure):
                print(failure.errorDescription)
            }
        }
        
//        NetworkBasic.shared.detailPhoto(id: "") { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }

}


//Codable: Decodable + Encodable
//Decodable만 해도 충분 (외부 구조를 가져오기만 하기 때문에)
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
