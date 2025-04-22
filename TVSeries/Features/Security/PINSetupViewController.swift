//
//  PINSetupViewController.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

final class PINSetupViewController: UIViewController {
    private let viewModel: PINSetupViewModel
    private let contentView: PINSetupView
    
    init(viewModel: PINSetupViewModel) {
        self.viewModel = viewModel
        self.contentView = PINSetupView()
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

extension PINSetupViewController: PINSetupViewDelegate {
    func pinSetupViewDidConfirmPIN(_ view: PINSetupView) {
        if let pin = view.getPIN() {
            viewModel.setPIN(pin)
        }
    }
    
    func pinSetupViewDidCancel(_ view: PINSetupView) {
        viewModel.cancel()
    }
} 
