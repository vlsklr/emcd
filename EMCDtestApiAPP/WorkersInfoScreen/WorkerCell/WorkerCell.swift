//
//  WorkerCellViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 26.06.2022.
//

import Foundation
import UIKit
import Reusable
import ReactiveCocoa
import ReactiveSwift

class WorkerCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var wokerNameLabel: UILabel!
    @IBOutlet private var workerHashrateLabel: UILabel!
    @IBOutlet private var workerHashrate1hLabel: UILabel!
    @IBOutlet private var workerHashrate24hLabel: UILabel!
    @IBOutlet private var workerActiveLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: WorkerCellViewModel? {
        didSet {
            setupBindings()
        }
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }
        wokerNameLabel.reactive.text <~ viewModel.worker
        workerHashrateLabel.reactive.text <~ viewModel.hashrate
        workerHashrate1hLabel.reactive.text <~ viewModel.hashrate1h
        workerHashrate24hLabel.reactive.text <~ viewModel.hashrate24h
        workerActiveLabel.reactive.text <~ viewModel.active
    }

}

extension WorkerCell: NibReusable {
}
