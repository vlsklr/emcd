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
    
    var pickedCoin = MutableProperty("BTC")
    
    //temp title update with callback
    var updateVal: ((String,UIControl.State) -> Void)?

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
//        pickedCoin.value = coins[indexPath.row]
//        pickedCoin.swap(coins[indexPath.row])
//        pickedCoin.value = coins[indexPath.row]
        pickedCoin = MutableProperty(coins[indexPath.row])
        
        //temp title update with callback
        updateVal?(coins[indexPath.row], .normal)
        
        dismiss(animated: true)
          
        
    }

}
