//
//  WorkersInfoViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 19.06.2022.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class WorkersInfoViewModel: CoinPickable {
    
    // MARK: - Properties
    
    private let service = NetworkService.shared
    var showAlert: (() -> Void)?
    var totalWorkers = MutableProperty("")
    var activeWorkers = MutableProperty("")
    var incativeWorkers = MutableProperty("")
    var hashrate = MutableProperty("")
    var hashrate1h = MutableProperty("")
    var hashrate24h = MutableProperty("")
    var pickedCoin = MutableProperty("BTC")
    var isEmptyTable = MutableProperty(true)
    var workers: MutableProperty<[WorkerInfo]> = MutableProperty<[WorkerInfo]>([])
    
    lazy var fetchAction: Action<Void, Void, Error> = {
        return .init(execute: { [weak self] _ -> SignalProducer<Void, Error> in
            return self?.fetchWorkersInfo() ?? .empty
        })
    }()
    
    init() {
        pickedCoin.signal.observeValues { [weak self] coin in
            self?.fetchAction.apply().start()
        }
    }
    
    private func fetchWorkersInfo() -> SignalProducer<Void, Error> {
        return .init { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendCompleted()
                return
            }
            
            lifetime += self.service.getInfoAboutWorker(coinName: self.pickedCoin.value.lowercased())
                .mapError{ error -> Error in
                    self.showAlert?()
                    return error
                }.map{ response -> Void in
                    guard let coinInfo = try? JSONDecoder().decode(WorkerInfoResponse.self, from: response.data) else { return }
                    self.totalWorkers.value = coinInfo.totalCount.all.description
                    self.activeWorkers.value = coinInfo.totalCount.active.description
                    self.incativeWorkers.value = coinInfo.totalCount.inactive.description
                    self.hashrate.value = coinInfo.totalHashrate.hashrate.description
                    self.hashrate1h.value = coinInfo.totalHashrate.hashrate1h.description
                    self.hashrate24h.value = coinInfo.totalHashrate.hashrate24h.description
                    self.workers = MutableProperty<[WorkerInfo]>(coinInfo.details)
                    self.isEmptyTable.value = self.workers.value.isEmpty
                    return()
                }.start(observer)
        }
    }
    
}
