//
//  BeerViewController.swift
//  SeSACWeek10
//
//  Created by 홍수만 on 2023/09/19.
//

import UIKit

class BeerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        BeerNetwork.shared.requestBeers { beer, error in
//            guard let beer = beer else {
//                return
//            }
//            dump(beer)
//        }
//        BeerNetwork.shared.requestSingleBeer { beer, error in
//            guard let beer = beer else {
//                return
//            }
//            dump(beer)
//        }
        
        BeerNetwork.shared.request(type: Beer.self, api: .beers) { response in
            switch response {
            case .success(let success):
                print("Beers----")
                dump(success)
            case.failure(let failure):
                print(failure.errorDescription)
            }
        }
        
        BeerNetwork.shared.request(type: Beer.self, api: .singleBeer) { response in
            switch response {
            case .success(let success):
                print("Single Beer----")
                dump(success)
            case.failure(let failure):
                print(failure.errorDescription)
            }
        }
        
        BeerNetwork.shared.request(type: Beer.self, api: .randomBeer) { response in
            switch response {
            case .success(let success):
                print("Random Beer----")
                dump(success)
            case.failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
}
