//
//  PayoutsViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import ReactiveSwift

final class PayoutsViewModel: CoinPickable {
    
    //MARK: - Properties
    
    let networkService = NetworkService()
    var pickedCoin = MutableProperty("BTC")
    var shouldUpdateTableView = MutableProperty(false)
    var payouts = MutableProperty<[PayoutsInfo]>([])
    
    lazy var fetchAction: Action<Void, Void, Error> = {
        return .init(execute: { [weak self] _ -> SignalProducer<Void, Error> in
            return self?.fetchAmounts() ?? .empty
        })
    }()
    
    init() {
        pickedCoin.signal.observeValues { [weak self] coin in
            self?.fetchAmounts().start()
        }
    }
    
    private func fetchAmounts() -> SignalProducer<Void, Error> {
        return .init { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendCompleted()
                return
            }            
            lifetime += self.networkService.getInfoAboutPayouts(coin: self.pickedCoin.value.lowercased())
                .mapError { error -> Error in
                    return error
                }.map { response -> Void in
                    guard let payoutsInfo = try? JSONDecoder().decode(PayoutsInfoResponse.self, from: response.data) else { return }
                    self.payouts = MutableProperty<[PayoutsInfo]>(payoutsInfo.payouts)
                    self.shouldUpdateTableView.value = self.payouts.value.isEmpty
                    return()
                }.start()
        }
        
    }
    
    
    
}
