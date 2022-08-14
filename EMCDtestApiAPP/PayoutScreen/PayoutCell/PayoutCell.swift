//
//  PayoutCellViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation
import UIKit
import Reusable
import ReactiveCocoa
import ReactiveSwift

class PayoutCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: PayoutCellViewModel? {
        didSet {
           setupBindings()
        }
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }
        dateLabel.reactive.text <~ viewModel.date
        amountLabel.reactive.text <~ viewModel.amount
    }
    
}

extension PayoutCell: NibReusable {
}
