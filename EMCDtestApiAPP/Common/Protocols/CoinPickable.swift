//
//  CoinPickable.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation
import ReactiveSwift

protocol CoinPickable {
    
    var pickedCoin: MutableProperty<String> { get set }
    var fetchAction: Action<Void, Void, Error> { get }

}
