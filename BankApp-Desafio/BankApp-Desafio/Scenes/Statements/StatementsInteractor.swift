//
//  StatementsInteractor.swift
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

protocol StatementsBusinessLogic {
    func showStatements()
}

protocol StatementsDataStore {
    var user: UserAccount? { get set }
    var statement: StatementAPIModel? { get set }
}

class StatementsInteractor: StatementsBusinessLogic, StatementsDataStore {
    var presenter: StatementsPresentationLogic?
    var worker: StatementsWorker?
    var user: UserAccount?
    var statement: StatementAPIModel?
    
    init(worker: StatementsWorker = StatementsWorker()) {
        self.worker = worker
    }
    
    func showStatements() {
        worker?.fetchStatementsList(completion: { (result) in
            switch result {
            case .success(let response):
                self.statement = response.statement
                self.presenter?.presentStatement(response: response)
            case .failure(let error):
                self.presenter?.presentErrorMessage(message: error.localizedDescription)
            }
        })
    }
}
