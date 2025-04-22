//
//  PINValidationViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import Foundation

protocol PINValidationViewModelDelegate: AnyObject {
    func pinValidationViewModelDidValidatePIN(_ viewModel: PINValidationViewModel)
    func pinValidationViewModelDidFailValidation(_ viewModel: PINValidationViewModel)
}

final class PINValidationViewModel {
    private let securityService: SecurityServiceProtocol
    weak var delegate: PINValidationViewModelDelegate?
    
    init(securityService: SecurityServiceProtocol) {
        self.securityService = securityService
    }
    
    func validatePIN(_ pin: String) {
        if securityService.validatePIN(pin) {
            delegate?.pinValidationViewModelDidValidatePIN(self)
        } else {
            delegate?.pinValidationViewModelDidFailValidation(self)
        }
    }
} 
