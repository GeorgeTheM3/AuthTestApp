//
//  StartScreenView.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 07.02.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class StartScreenView: UIView {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fon-2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number"
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: "AlNile-Bold", size: 15)
        return label
    }()

    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.text = "+7 "
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(changeValue), for: .allEditingEvents)
        return textField
    }()
    
    private lazy var smsCodeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.placeholder = "Enter code"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        textField.addTarget(self, action: #selector(changeValue), for: .allEditingEvents)
        return textField
    }()
    
    // if change text field text
    @objc private func changeValue() {
        guard let text = phoneNumberTextField.text else { return }
        guard text.hasPrefix("+7 ") else { return phoneNumberTextField.text = "+7 "}
        if text.count > 15 {
            phoneNumberTextField.text?.removeLast()
        }
    }

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "AlNile-Bold", size: 20)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraintsViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setConstraintsViews()
    }

    private func addViews() {
        addSubview(backgroundImageView)
        addSubview(signInButton)
        addSubview(phoneLabel)
        addSubview(phoneNumberTextField)
        addSubview(smsCodeTextField)
    }

    private func setConstraintsViews() {
        backgroundImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
        smsCodeTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.bottom.equalTo(phoneNumberTextField.snp.top)
            make.leading.equalTo(phoneNumberTextField.snp.leading)
        }
        
        signInButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(42)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
        }
    }
    
    private func showSmsCodeTextField() {
        UIView.animate(withDuration: 1) {
            self.phoneLabel.transform = CGAffineTransform(translationX: 0, y: -70)
            self.phoneNumberTextField.transform = CGAffineTransform(translationX: 0, y: -70)
            self.smsCodeTextField.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.smsCodeTextField.transform = .identity
                self.smsCodeTextField.isHidden = false
            }
            self.phoneNumberTextField.layoutIfNeeded()
            self.smsCodeTextField.layoutIfNeeded()
            self.phoneLabel.layoutIfNeeded()
        }
    }
}

extension StartScreenView: DelegatePressedButtonProtocol {
    func buttonPressed(buttonName: Constants.Buttons, selector: Selector) {
        switch buttonName {
        case .signIn:
            signInButton.addTarget(Any.self, action: selector, for: .touchUpInside)
        default:
            break
        }
    }
}

extension StartScreenView: DelegateToControllerProtocol {
    func passToController<T>(info: T?) -> T? {
        if let phone = phoneNumberTextField.text, let code = smsCodeTextField.text {
            return User(phoneNumber: phone, smsCode: code) as? T
        }
        return nil
    }
}

extension StartScreenView: DelegateStatusProtocol {
    func setStatus<T>(info: T?) -> T? {
        if let info = info as? Bool, info == true {
            showSmsCodeTextField()
            signInButton.setTitle("Enter code", for: .normal)
        }
        return nil
    }
}

