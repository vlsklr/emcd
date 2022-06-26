//
//  WorkerInfoResponse.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 05.06.2022.
//

import Foundation

struct WorkerInfoResponse {
    let totalCount: WorkersTotalCount
    let totalHashrate: WorkersTotalHashrate
    let details: [WorkerInfo]
}

extension WorkerInfoResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case totalHashrate = "total_hashrate"
        case details
    }
    
}

struct WorkersTotalCount {
    let all: Int
    let active: Int
    let inactive: Int
}

extension WorkersTotalCount: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case all
        case active
        case inactive
    }
    
}

struct WorkersTotalHashrate {
    let hashrate: Int
    let hashrate1h: Int
    let hashrate24h: Int
}

extension WorkersTotalHashrate: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case hashrate
        case hashrate1h
        case hashrate24h
    }
    
}

struct WorkerInfo {
    let worker: String
    let hashrate: Int
    let hashrate1h: Int
    let hashrate24h: Int
    let active: Int
}

extension WorkerInfo: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case worker
        case hashrate
        case hashrate1h
        case hashrate24h
        case active
    }
    
}
