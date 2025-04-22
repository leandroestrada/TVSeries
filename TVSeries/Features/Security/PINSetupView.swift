//
//  PINSetupView.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

protocol PINSetupViewDelegate: AnyObject {
    func pinSetupViewDidConfirmPIN(_ view: PINSetupView)
    func pinSetupViewDidCancel(_ view: PINSetupView)
}

final class PINSetupView: UIView {
    weak var delegate: PINSetupViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.title
        label.textAlignment = .center
        label.text = "Set PIN"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.body
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Enter a 4-digit PIN to secure your app"
        return label
    }()
    
    private let pinTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = UIConstants.CornerRadius.medium
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = UIConstants.CornerRadius.medium
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(pinTextField)
        addSubview(confirmButton)
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIConstants.Spacing.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.Spacing.medium),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            pinTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: UIConstants.Spacing.large),
            pinTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            pinTextField.widthAnchor.constraint(equalToConstant: 120),
            pinTextField.heightAnchor.constraint(equalToConstant: 44),
            
            confirmButton.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: UIConstants.Spacing.large),
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
            cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: UIConstants.Spacing.medium),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        pinTextField.delegate = self
    }
    
    private func setupActions() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func confirmButtonTapped() {
        delegate?.pinSetupViewDidConfirmPIN(self)
    }
    
    @objc private func cancelButtonTapped() {
        delegate?.pinSetupViewDidCancel(self)
    }
    
    func getPIN() -> String? {
        return pinTextField.text
    }
}

extension PINSetupView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
} 
