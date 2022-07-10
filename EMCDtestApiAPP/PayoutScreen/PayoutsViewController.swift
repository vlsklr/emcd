//
//  PayoutsViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

final class PayoutsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var coinPickerButton: UIButton!
    @IBOutlet weak var payoutsTableVIew: UITableView!
    
    // MARK: - Properties
    
    let viewModel = PayoutsViewModel()
    
    private lazy var refreshControl: UIRefreshControl = {
            return UIRefreshControl()
        }()
    
    var coinPickerVC: CoinPickerViewController? {
        let storyboard = UIStoryboard(name: "CoinPicker", bundle: nil)
        guard let coinPickerVC = storyboard.instantiateViewController(withIdentifier: "coinPickerVC") as? CoinPickerViewController else { return nil }

        coinPickerVC.modalPresentationStyle = .popover

        let popoverVC = coinPickerVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = coinPickerButton
        popoverVC?.sourceRect = CGRect(x: self.coinPickerButton.bounds.midX, y: self.coinPickerButton.bounds.maxY, width: 0, height: 0)
        coinPickerVC.preferredContentSize = CGSize(width: 250, height: 250)
        coinPickerVC.viewModel = viewModel

        return coinPickerVC
    }
    
    @IBAction func coinPickerButtonTapped(_ sender: Any) {
        guard let coinPickerVC = coinPickerVC else {
            return
        }
        present(coinPickerVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAction.apply().start()
        
        coinPickerButton.reactive.title <~ viewModel.pickedCoin
        payoutsTableVIew.dataSource = self
        payoutsTableVIew.register(cellType: PayoutCellViewController.self)
        
        payoutsTableVIew.reactive.isHidden <~ viewModel.shouldUpdateTableView
        refreshControl.reactive.refresh = .init(viewModel.fetchAction)
        payoutsTableVIew.refreshControl = refreshControl

        viewModel.shouldUpdateTableView.signal.observeValues { [weak self] _ in
            self?.payoutsTableVIew.reloadData()
        }
    }
    
}

extension PayoutsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        payoutsTableVIew.deselectRow(at: indexPath, animated: false)
    }
    
}

extension PayoutsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.payouts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PayoutCellViewController = tableView.dequeueReusableCell(for: indexPath)
        let payoutInfo = viewModel.payouts.value[indexPath.row]
        cell.viewModel = PayoutCellViewModel(date: payoutInfo.gmtTime, amount: "\(payoutInfo.amount)")
        return cell
    }
    
    
}

// MARK: - UIPopoverPresentationControllerDelegate. Needs for coinPicker

extension PayoutsViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

