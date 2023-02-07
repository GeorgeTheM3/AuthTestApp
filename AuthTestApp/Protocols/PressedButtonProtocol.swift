//
//  PressedButtonProtocol.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 07.02.2023.
//

import Foundation
import UIKit

protocol DelegatePressedButtonProtocol: AnyObject {
    func buttonPressed(buttonName: Constants.Buttons, selector: Selector)
}
