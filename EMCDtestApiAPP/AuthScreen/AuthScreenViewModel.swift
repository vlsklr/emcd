//
//  AuthScreenViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 02.10.2022.
//

import Foundation
import ReactiveSwift

class AuthScreenViewModel {
    
    let networkService = NetworkService.shared
    var apiKey = MutableProperty<String?>("")
    var isLoginButtonEnabled = MutableProperty<Bool>(false)
    var showAlert: (() -> Void)?
    var showMainScreen: (() -> Void)?
    
    lazy var fetchAction: Action<Void, Void, Error> = {
        return .init(execute: { [weak self] _ -> SignalProducer<Void, Error> in
            return self?.fetchUserInfoData() ?? .empty
        })
    }()
    
    init() {
        apiKey.signal.observeValues { [weak self] apiKey in
            self?.networkService.apiKey = apiKey
            self?.isLoginButtonEnabled.value = !(apiKey?.isEmpty ?? true)
        }
    }
    
    func fetchUserInfoData() -> SignalProducer<Void, Error> {
        return .init { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendCompleted()
                return
            }
            
            lifetime += self.networkService.getCommonInfo()
                .mapError { error -> Error in
                    self.showAlert?()
                    return error as Error
                }
                .map { response -> Void in
                    if response.statusCode == 200 {
                        self.showMainScreen?()
                    } else {
                        self.showAlert?()
                    }
                    return ()
                }
                .start(observer)
        }
    }
}
