//
//  ViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 10.05.2022.
//

import Foundation
import ReactiveSwift
import Moya

class CommonInfoViewModel {
    
    var userNameProperty = MutableProperty("")
    
    var btcBalance = MutableProperty("")
    var btcTotalPaid = MutableProperty("")
    var btcAddress = MutableProperty("")
    
    var ltcBalance = MutableProperty("")
    var ltcTotalPaid = MutableProperty("")
    var ltcAcddress = MutableProperty("")
    
    var dogeBalance = MutableProperty("")
    var dogeTotalPaid = MutableProperty("")
    var dogeAcddress = MutableProperty("")
    
    lazy var fetchAction: Action<Void, Void, Error> = {
        return .init(execute: { [weak self] _ -> SignalProducer<Void, Error> in
            return self?.fetchData() ?? .empty
        })
    }()
    
    private let service = NetworkService()
    
    func fetch() {

        service.getCoinInfo(coinName: "doge").startWithResult { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response)
            }
        }
    }
    
    func fetchData() -> SignalProducer<Void, Error> {
        return .init { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendCompleted()
                return
            }
            
            lifetime += self.service.getCommonInfo()
                .mapError { error -> Error in
                    return error as Error
                }
                .map { response -> Void in
//                    let response = result
//                    print(response)
                    guard let commonInfo = try? JSONDecoder().decode(CommonInfoResponse.self, from: response.data) else { return }
                    self.userNameProperty.value = commonInfo.userName
                    
                    self.btcBalance.value = commonInfo.bitcoin.balance ?? "Нет данных"
                    self.btcTotalPaid.value = commonInfo.bitcoin.totalPaid ?? "Нет данных"
                    self.btcAddress.value = commonInfo.bitcoin.address ?? "Нет данных"
                    
                    self.ltcBalance.value = commonInfo.litecoin.balance ?? "Нет данных"
                    self.ltcAcddress.value = commonInfo.litecoin.address ?? "Нет данных"
                    self.ltcTotalPaid.value = commonInfo.litecoin.totalPaid ?? "Нет данных"
                    
                    self.dogeBalance.value = commonInfo.doge.balance ?? "Нет данных"
                    self.dogeAcddress.value = commonInfo.doge.address ?? "Нет данных"
                    self.dogeTotalPaid.value = commonInfo.doge.totalPaid ?? "Нет данных"
                    return ()
                }
                .start(observer)
            
        }
    }
    
}
