//
//  PayoutsInfoResponse.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation

struct PayoutsInfoResponse: Decodable {
    let payouts: [PayoutsInfo]
}

//// MARK: - Decodable
//
//extension PayoutsInfoResponse: Decodable {
//
//    enum CodingKeys: String, CodingKey {
//        case payouts
//    }
//
//}

struct PayoutsInfo {
    
    //MARK: - Properties
    
    let timestamp: Int
    let gmtTime: String
    let amount: Double
    let txid: String
    
    
}


extension PayoutsInfo: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case gmtTime = "gmt_time"
        case amount, txid
    }
    
}
