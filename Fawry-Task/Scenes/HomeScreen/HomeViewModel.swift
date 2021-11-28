//
//  HomeViewModel.swift
//  Fawry-Task
//
//  Created by Labeeb on 27/11/2021.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var bag: DisposeBag = DisposeBag()
    var homeItems: BehaviorSubject<[HomeImageItem]> = BehaviorSubject(value: [])
    let networkManager: NetworkManager<HomeData> = NetworkManager<HomeData>.init()
    
    func getHomeData() {
        networkManager.fetchRequest(request: HomeData.getHomeList) { [weak self] (result:Result<[HomeImageItem],Error>) in
            switch result {
            case .success(let items):
                self?.homeItems.on(.next(items))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

