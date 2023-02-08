//
//  DelegateToControllerProtocol.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 08.02.2023.
//

import Foundation

protocol DelegateToControllerProtocol: AnyObject {
    func passToController<T>(info: T?) -> T?
}
