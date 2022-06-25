//
//  WorkersInfoViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 19.06.2022.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class WorkersInfoViewModel {
    
    // MARK: - Properties
    
    private let service = NetworkService()
    var totalWorkers = MutableProperty("")
    var activeWorkers = MutableProperty("")
    var incativeWorkers = MutableProperty("")
    var pickedCoin = MutableProperty("BTC")
    
    
    lazy var fetchWorkersAction: Action<Void, Void, Error> = {
        return .init(execute: { [weak self] _ -> SignalProducer<Void, Error> in
            return self?.fetchWorkersInfo() ?? .empty
        })
    }()
    
    private func fetchWorkersInfo() -> SignalProducer<Void, Error> {
        return .init { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendCompleted()
                return
            }
            
            lifetime += self.service.getInfoAboutWorker(coinName: self.pickedCoin.value.lowercased())
                .mapError{ error -> Error in
                    return error
                }.map{ response -> Void in
                    guard let coinInfo = try? JSONDecoder().decode(WorkerInfoResponse.self, from: response.data) else { return }
                    self.totalWorkers.value = coinInfo.totalCount.all.description
                    self.activeWorkers.value = coinInfo.totalCount.active.description
                    self.incativeWorkers.value = coinInfo.totalCount.inactive.description
                    return()
                }.start(observer)
        }
    }
    
}
