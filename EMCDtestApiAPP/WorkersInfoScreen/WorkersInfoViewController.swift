//
//  WorkersInfoViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 19.06.2022.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

class WorkersInfoViewController: UIViewController {
    
    @IBOutlet var coinPickerButton: UIButton!
    @IBOutlet var workersTableView: UITableView!
    @IBOutlet var allWorkersLabel: UILabel!
    @IBOutlet var activeWorkersLabel: UILabel!
    @IBOutlet var inactiveWorkersLabel: UILabel!
    @IBOutlet var hashrateLabel: UILabel!
    @IBOutlet var hashrate1hLabel: UILabel!
    @IBOutlet var hashrate24hLabel: UILabel!
    
    let viewModel = WorkersInfoViewModel()
    var coinPickerVC: CoinPickerViewController? {
        guard let coinPickerVC = storyboard?.instantiateViewController(withIdentifier: "coinPickerVC") as? CoinPickerViewController else { return nil }
        
        coinPickerVC.modalPresentationStyle = .popover
        
        let popoverVC = coinPickerVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = coinPickerButton
        popoverVC?.sourceRect = CGRect(x: self.coinPickerButton.bounds.midX, y: self.coinPickerButton.bounds.maxY, width: 0, height: 0)
        coinPickerVC.preferredContentSize = CGSize(width: 250, height: 250)
        coinPickerVC.viewModel = viewModel
        
        return coinPickerVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchWorkersAction.apply().start()
        workersTableView.dataSource = self
        
        coinPickerButton.reactive.title <~ viewModel.pickedCoin
        allWorkersLabel.reactive.text <~ viewModel.totalWorkers
        activeWorkersLabel.reactive.text <~ viewModel.activeWorkers
        inactiveWorkersLabel.reactive.text <~ viewModel.incativeWorkers
        


    }
    
    @IBAction func coinPickerTapped(_ sender: Any) {
        guard let coinPickerVC = coinPickerVC else {
            return
        }
        present(coinPickerVC, animated: true)
    }
    
}

extension WorkersInfoViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

extension WorkersInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workersTableView.dequeueReusableCell(withIdentifier: "workerCell", for: indexPath)
        return cell
    }
}
