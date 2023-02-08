//
//  StartScreenViewController.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 07.02.2023.

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    private weak var delegateToStartView: DelegatePressedButtonProtocol?
    private weak var getInfoFromView: DelegateToControllerProtocol?
    private weak var setStatus: DelegateStatusProtocol?
    
    private var enteredPhoneNumber: Bool
    
    init(enteredPhoneNumber: Bool) {
        self.enteredPhoneNumber = enteredPhoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = delegateToView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction()
        gestureCloseKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatus?.setStatus(info: enteredPhoneNumber)
    }
    
    // gesture tap to close keyboard
    private func gestureCloseKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardSwipe))
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    @objc private func closeKeyboardSwipe(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    deinit {
        print("killed start view controller")
    }
    
    private func delegateToView() -> UIView {
        let view = StartScreenView()
        delegateToStartView = view
        getInfoFromView = view
        setStatus = view
        return view
    }

    private func buttonAction() {
        delegateToStartView?.buttonPressed(buttonName: .signIn, selector: #selector(signInAction))
    }
    
    @objc private func signInAction() {
        guard let user = getInfoFromView?.passToController(info: User()) else { return }
        if user.smsCode == "" {
            AuthManager.shared.startAuth(phoneNumber: user.phoneNumber) { success in
                guard success else { return }
                DispatchQueue.main.async {
                    print("success")
                }
            }
            self.enteredPhoneNumber = true
        } else {
            AuthManager.shared.verifyCode(smsCode: user.smsCode) { success in
                guard success else { return }
                DispatchQueue.main.async {
                    let mainViewController = MainViewController()
                    mainViewController.modalPresentationStyle = .fullScreen
                    self.present(mainViewController, animated: true)
                }
            }
        }
    }
}
