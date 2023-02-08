//
//  MainViewController.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 08.02.2023.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        do {
           try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
