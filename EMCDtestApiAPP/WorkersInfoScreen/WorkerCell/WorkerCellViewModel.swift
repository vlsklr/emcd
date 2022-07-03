//
//  WorkerCellViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 03.07.2022.
//

import Foundation
import ReactiveSwift

final class WorkerCellViewModel {
    
    // MARK: - Properties
    
    var worker = MutableProperty("")
    var hashrate = MutableProperty("")
    var hashrate1h = MutableProperty("")
    var hashrate24h = MutableProperty("")
    var active = MutableProperty("")
    
    // MARK: - Initializer
    
    init(with workerInfo: WorkerInfo) {
        worker.value = workerInfo.worker
        hashrate.value = workerInfo.hashrate.description
        hashrate1h.value = workerInfo.hashrate1h.description
        hashrate24h.value = workerInfo.hashrate24h.description
    }
    
}
