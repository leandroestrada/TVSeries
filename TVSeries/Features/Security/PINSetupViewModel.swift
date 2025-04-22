//
//  PINSetupViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import Foundation

protocol PINSetupViewModelDelegate: AnyObject {
    func pinSetupViewModelDidSetPIN(_ viewModel: PINSetupViewModel)
    func pinSetupViewModelDidCancel(_ viewModel: PINSetupViewModel)
}

final class PINSetupViewModel {
    private let securityService: SecurityServiceProtocol
    weak var delegate: PINSetupViewModelDelegate?
    
    init(securityService: SecurityServiceProtocol) {
        self.securityService = securityService
    }
    
    func setPIN(_ pin: String) {
        guard pin.count == 4, pin.allSatisfy({ $0.isNumber }) else { return }
        securityService.setPIN(pin)
        delegate?.pinSetupViewModelDidSetPIN(self)
    }
    
    func cancel() {
        delegate?.pinSetupViewModelDidCancel(self)
    }
} 
