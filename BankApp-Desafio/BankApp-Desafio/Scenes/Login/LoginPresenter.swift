//
//  LoginPresenter.swift
//  BankApp-Desafio
//
//  Created by Mizia Lima on 2/26/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginPresentationLogic {
    func presentLoginUser(response: Login.Response)
    func presentErrorMessage(message: String)
    func loadingUser()
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginUser(response: Login.Response) {
        viewController?.displayLoginSuccess()
        viewController?.hideLoading()
    }
    
    func presentErrorMessage(message: String) {
        viewController?.showLoginFailureAlert(title: "Opa, Houve um erro.", message: message)
        viewController?.hideLoading()
    }
    
    func loadingUser() {
        viewController?.showLoading()
    }
    
    func getLastUserLogged(user: String, password: String) {
        viewController?.fillLastUser(user: user, password: password)
    }
}
