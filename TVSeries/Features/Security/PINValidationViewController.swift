//
//  PINValidationViewController.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

final class PINValidationViewController: UIViewController {
    private let viewModel: PINValidationViewModel
    private let contentView: PINValidationView
    
    init(viewModel: PINValidationViewModel) {
        self.viewModel = viewModel
        self.contentView = PINValidationView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PINValidationViewController: PINValidationViewDelegate {
    func pinValidationViewDidEnterPIN(_ view: PINValidationView) {
        if let pin = view.getPIN() {
            viewModel.validatePIN(pin)
        }
    }
}

extension PINValidationViewController: PINValidationViewModelDelegate {
    func pinValidationViewModelDidValidatePIN(_ viewModel: PINValidationViewModel) {
    }
    
    func pinValidationViewModelDidFailValidation(_ viewModel: PINValidationViewModel) {
        contentView.showError("Invalid PIN")
        contentView.clearPIN()
    }
} 
