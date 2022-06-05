//
//  CommonInfoResponse.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 14.05.2022.
//

import Foundation

struct CommonInfoResponse {
    let userName: String
    let bitcoin: CommonCoinInfo
    let litecoin: CommonCoinInfo
    let doge: CommonCoinInfo
}

extension CommonInfoResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case bitcoin
        case litecoin
        case doge
    }
}

struct CommonCoinInfo {
    let balance: String?
    let totalPaid: String?
    let address: String?
}

extension CommonCoinInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case balance
        case totalPaid = "total_paid"
        case address
    }
}
