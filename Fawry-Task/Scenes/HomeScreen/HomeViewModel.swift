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
    
    
    func logout() {
        let defaults = UserDefaultsManager.manager
        defaults.saveLogin(status: false)
    }
    
    func getHomeData() {
        getingMoreActive = true
        let endPoint = HomeEndPoints.getHomeList(currentPage, limit)
        networkManager.fetchRequest(request: endPoint) { [weak self] (result:Result<[HomeImageItem],Error>) in
            self?.getingMoreActive = false
            switch result {
            case .success(let items):
                self?.successGetNewData(items: items)
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
                self?.successGetNewData(items: items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func successGetNewData(items : [HomeImageItem]) {
        
        let newItems = insertMockItems(items: items)
        
        if let oldItems = try? self.homeItemsSubject.value() {
            self.homeItemsSubject.on(.next(oldItems + newItems))
        }else {
            self.homeItemsSubject.on(.next(newItems))
        }
    }
    
    func insertMockItems(items : [HomeImageItem]) -> [HomeImageItem] {
        var items = items
        let count = limit / 5
        print(count)
        for i in 1...count {
            let moc = HomeImageItem.init(id: "", author: "",isMocImage:true, width: nil, height: nil, url: nil, downloadURL: "")
            items.insert(moc, at: (i * 5) + (i - 1))
        }
        return items
    }
    
}

