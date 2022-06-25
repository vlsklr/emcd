//
//  CoinPickerViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 19.06.2022.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class CoinPickerViewController: UITableViewController {
    let coins = [ "BTC",
                  "DOGE",
                  "LTC" ]
    var viewModel: WorkersInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        cell.textLabel?.text = coins[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.pickedCoin.value = coins[indexPath.row]
        viewModel?.fetchWorkersAction.apply().start()
        dismiss(animated: true)
    }

}
