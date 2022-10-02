//
//  ErrorAlert.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 02.10.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Something wrong", message: "Try again later", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
