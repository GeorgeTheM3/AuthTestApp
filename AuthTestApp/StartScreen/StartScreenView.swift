//
//  StartScreenView.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 07.02.2023.
//

import Foundation
import UIKit
import SnapKit

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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont(name: "AlNile-Bold", size: 15)
        return label
    }()

    private lazy var enterYourPhoneNumberTaxtField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

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
        addSubview(enterYourPhoneNumberTaxtField)
    }

    private func setConstraintsViews() {
        backgroundImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        enterYourPhoneNumberTaxtField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.bottom.equalTo(enterYourPhoneNumberTaxtField.snp.top)
            make.leading.equalTo(enterYourPhoneNumberTaxtField.snp.leading)
        }
        
        signInButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(42)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(enterYourPhoneNumberTaxtField.snp.bottom).offset(20)
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
