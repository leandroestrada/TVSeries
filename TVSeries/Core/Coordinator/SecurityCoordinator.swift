//
//  SecurityCoordinator.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

protocol SecurityCoordinatorDelegate: AnyObject {
    func securityCoordinatorDidFinish(_ coordinator: SecurityCoordinator)
}

final class SecurityCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var delegate: SecurityCoordinatorDelegate?
    
    private let securityService: SecurityServiceProtocol
    
    init(navigationController: UINavigationController, securityService: SecurityServiceProtocol) {
        self.navigationController = navigationController
        self.securityService = securityService
    }
    
    func start() {
        if securityService.isPINSet {
            showPINValidation()
        } else {
            showPINSetup()
        }
    }
    
    private func showPINSetup() {
        let viewModel = PINSetupViewModel(securityService: securityService)
        viewModel.delegate = self
        let viewController = PINSetupViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showPINValidation() {
        let viewModel = PINValidationViewModel(securityService: securityService)
        viewModel.delegate = self
        let viewController = PINValidationViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}

extension SecurityCoordinator: PINSetupViewModelDelegate {
    func pinSetupViewModelDidSetPIN(_ viewModel: PINSetupViewModel) {
        delegate?.securityCoordinatorDidFinish(self)
    }
    
    func pinSetupViewModelDidCancel(_ viewModel: PINSetupViewModel) {
        delegate?.securityCoordinatorDidFinish(self)
    }
}

extension SecurityCoordinator: PINValidationViewModelDelegate {
    func pinValidationViewModelDidValidatePIN(_ viewModel: PINValidationViewModel) {
        delegate?.securityCoordinatorDidFinish(self)
    }
    
    func pinValidationViewModelDidFailValidation(_ viewModel: PINValidationViewModel) {
    }
}
