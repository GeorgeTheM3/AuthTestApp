//
//  StartScreenViewController.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 07.02.2023.

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    private weak var delegateToStartView: DelegatePressedButtonProtocol?
    
    override func loadView() {
        super.loadView()
        self.view = delegateToView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction()
        gestureCloseKeyboard()
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
        return view
    }

    private func buttonAction() {
        delegateToStartView?.buttonPressed(buttonName: .signIn, selector: #selector(signInAction))
    }
    
    @objc private func signInAction() {
    }
}
