//
//  WorkerCellViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 26.06.2022.
//

import Foundation
import UIKit
import Reusable

class WorkerCell: UITableViewCell {
    
    @IBOutlet var wokerNameLabel: UILabel!
    @IBOutlet var workerHashrateLabel: UILabel!
    @IBOutlet var workerHashrate1hLabel: UILabel!
    @IBOutlet var workerHashrate24hLabel: UILabel!
    @IBOutlet var workerActiveLabel: UILabel!
    
}

extension WorkerCell: NibReusable {
    
}
