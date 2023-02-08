//
//  SetStatusProtocol.swift
//  AuthTestApp
//
//  Created by Георгий Матченко on 08.02.2023.
//

import Foundation

protocol DelegateStatusProtocol: AnyObject {
    func setStatus<T>(info: T?) -> T?
}
