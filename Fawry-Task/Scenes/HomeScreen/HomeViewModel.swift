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
    var homeItemsSubject: BehaviorSubject<[HomeImageItem]> = BehaviorSubject(value: [])
    
    let networkManager: NetworkManager<HomeEndPoints> = NetworkManager<HomeEndPoints>.init()
    private var currentPage = 1
    private let limit = 10
    private var getingMoreActive = false
    func getHomeData() {
        let endPoint = HomeEndPoints.getHomeList(currentPage, limit)
        networkManager.fetchRequest(request: endPoint) { [weak self] (result:Result<[HomeImageItem],Error>) in
            switch result {
            case .success(let items):
                self?.homeItemsSubject.on(.next(items))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getMoreHomeData() {
        if getingMoreActive {
            return
        }else {
            getingMoreActive = true
        }
        
        currentPage = currentPage + 1
        let endPoint = HomeEndPoints.getHomeList(currentPage, limit)
        networkManager.fetchRequest(request: endPoint) { [weak self] (result:Result<[HomeImageItem],Error>) in
            self?.getingMoreActive = false
            switch result {
            case .success(let items):
                if let oldItems = try? self?.homeItemsSubject.value() {
                    self?.homeItemsSubject.on(.next(oldItems + items))
                }else {
                    self?.homeItemsSubject.on(.next(items))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

