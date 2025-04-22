//
//  PINSetupViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

protocol PINValidationViewDelegate: AnyObject {
    func pinValidationViewDidEnterPIN(_ view: PINValidationView)
}

final class PINValidationView: UIView {
    weak var delegate: PINValidationViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.title
        label.textAlignment = .center
        label.text = "Enter PIN"
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
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.caption
        label.textAlignment = .center
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(pinTextField)
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIConstants.Spacing.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            pinTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.Spacing.large),
            pinTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            pinTextField.widthAnchor.constraint(equalToConstant: 120),
            pinTextField.heightAnchor.constraint(equalToConstant: 44),
            
            errorLabel.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: UIConstants.Spacing.medium),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium)
        ])
        
        pinTextField.delegate = self
        pinTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        if let text = pinTextField.text, text.count == 4 {
            delegate?.pinValidationViewDidEnterPIN(self)
        }
    }
    
    func getPIN() -> String? {
        return pinTextField.text
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func clearPIN() {
        pinTextField.text = ""
    }
}

extension PINValidationView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
} 
