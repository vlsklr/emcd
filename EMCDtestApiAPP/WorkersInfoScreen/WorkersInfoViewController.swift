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
    
    var coinPickerVC: CoinPickerViewController? {
        guard let coinPickerVC = storyboard?.instantiateViewController(withIdentifier: "coinPickerVC") as? CoinPickerViewController else { return nil }
        
        coinPickerVC.modalPresentationStyle = .popover
        
        let popoverVC = coinPickerVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = self.coinPickerButton
        popoverVC?.sourceRect = CGRect(x: self.coinPickerButton.bounds.midX, y: self.coinPickerButton.bounds.maxY, width: 0, height: 0)
        coinPickerVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        // temp callback title update
        coinPickerVC.updateVal = self.coinPickerButton.setTitle
        
        return coinPickerVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let coinPickerVC = coinPickerVC else { return }
        coinPickerButton.reactive.title <~ coinPickerVC.pickedCoin
    }
    
    @IBAction func coinPickerTapped(_ sender: Any) {
        guard let coinPickerVC = coinPickerVC else {
            return
        }
        self.present(coinPickerVC, animated: true)
    }
    
}

extension WorkersInfoViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
