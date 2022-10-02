//
//  AuthScreenViewController.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 02.10.2022.
//

import Foundation
import UIKit
import ReactiveSwift

class AuthScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = AuthScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.showAlert = showErrorAlert
        viewModel.showMainScreen = { [weak self] in
            self?.performSegue(withIdentifier: "showMainScreen", sender: self)
        }
        
        viewModel.apiKey <~ apiKeyTextField.reactive.continuousTextValues
        
        loginButton.reactive.pressed = .init(viewModel.fetchAction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.reactive.isEnabled <~ viewModel.isLoginButtonEnabled
    }
}
