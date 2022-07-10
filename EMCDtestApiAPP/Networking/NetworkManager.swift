//
//  NetworkManager.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 10.05.2022.
//

import Foundation
import Moya

enum NetworkManager {
    case getCommonInfo
    case getInfoAboutWorker(coin: String)
    case getInfoAboutPayouts(coin: String)
}

extension NetworkManager: TargetType {
    
    private var key: String {
        return "dc9bb0a3-8689-45a5-9b77-d6da1226fc60"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.emcd.io/v1")!
    }
    
    var path: String {
        switch self {
        case .getCommonInfo:
            return "/info/\(key)"
        case .getInfoAboutWorker(let coin):
            return "/\(coin)/workers/\(key)"
        case .getInfoAboutPayouts(coin: let coin):
            return "/\(coin)/payouts/\(key)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCommonInfo,
             .getInfoAboutWorker,
             .getInfoAboutPayouts:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
