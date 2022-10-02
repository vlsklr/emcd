//
//  NetworkService.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 10.05.2022.
//

import Foundation
import ReactiveSwift
import Moya
import ReactiveMoya

class NetworkService {
    
    static let shared = NetworkService()
    
    var apiKey: String?
    
    private let provider = MoyaProvider<NetworkManager>()
    
    private init() {}
    
    func getCommonInfo() -> SignalProducer<Response, MoyaError> {
        return provider.reactive.request(.getCommonInfo)
    }
    
    func getInfoAboutWorker(coinName: String) -> SignalProducer<Response, MoyaError> {
        return provider.reactive.request(.getInfoAboutWorker(coin: coinName))
    }
    
    func getInfoAboutPayouts(coin: String) -> SignalProducer<Response, MoyaError> {
        return provider.reactive.request(.getInfoAboutPayouts(coin: coin))
    }
    
}
