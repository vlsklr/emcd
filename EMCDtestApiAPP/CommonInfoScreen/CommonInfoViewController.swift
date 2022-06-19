//
//  ViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 10.05.2022.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class CommonInfoViewController: UIViewController {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var btcBalanceLabel: UILabel!
    @IBOutlet private weak var btcTotalPaidLabel: UILabel!
    @IBOutlet private weak var btcAddressLabel: UILabel!
    @IBOutlet private weak var ltcBalanceLabel: UILabel!
    @IBOutlet private weak var ltcTotalPaidLabel: UILabel!
    @IBOutlet private weak var ltcAddressLabel: UILabel!
    @IBOutlet private weak var dogeBalanceLabel: UILabel!
    @IBOutlet private weak var dogeTotalPaidLabel: UILabel!
    @IBOutlet private weak var dogeAddressLabel: UILabel!
    
    private lazy var refreshControl: UIRefreshControl = {
            return UIRefreshControl()
        }()
    
    let viewModel = CommonInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.reactive.text <~ viewModel.userNameProperty
        btcBalanceLabel.reactive.text <~ viewModel.btcBalance
        btcTotalPaidLabel.reactive.text <~ viewModel.btcTotalPaid
        btcAddressLabel.reactive.text <~ viewModel.btcAddress
        
        ltcAddressLabel.reactive.text <~ viewModel.ltcAcddress
        ltcBalanceLabel.reactive.text <~ viewModel.ltcBalance
        ltcTotalPaidLabel.reactive.text <~ viewModel.ltcTotalPaid
        
        dogeAddressLabel.reactive.text <~ viewModel.dogeAcddress
        dogeBalanceLabel.reactive.text <~ viewModel.dogeBalance
        dogeTotalPaidLabel.reactive.text <~ viewModel.dogeTotalPaid
        
        viewModel.fetchAction.apply().start()
                
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.size.height - 220))
        view.addSubview(scrollView)
       
        refreshControl.reactive.refresh = .init(viewModel.fetchAction)
        scrollView.refreshControl = refreshControl
    }

}

