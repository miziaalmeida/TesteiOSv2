//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class {
    func showLoginFailureAlert(title: String, message: String)
    func displayLoginSuccess()
    func showLoading()
    func hideLoading()
    func fillLastUser(user: String, password: String)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    //MARK: Properties
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.placeholder = "User"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .equalCentering
        [self.userTextField,
         self.passwordTextField].forEach { stack.addArrangedSubview($0) }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .mediumBlue()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup(){
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        interactor?.getLastUser()
    }
    
    @objc func tapLogin() {
        interactor?.login(username: userTextField.text, password: passwordTextField.text)
    }
    
    func displayLoginSuccess() {
        router?.routeToStatements()
    }
    
    //MARK: For Keychain
    func fillLastUser(user: String, password: String) {
        userTextField.text = user
        passwordTextField.text = password
        
    }
    //MARK: View Hierarchy
    func setupViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(loadingView)
        stackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(passwordTextField)
    }
    
    //MARK: Constraints
    func setupConstraints() {
        loadingView.contraintAllEdges(to: self.view)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
                logoImageView.heightAnchor.constraint(equalToConstant: 70),
                logoImageView.widthAnchor.constraint(equalToConstant: 125),
                
                userTextField.heightAnchor.constraint(equalToConstant: 50),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                
                stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 86),
                loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -86),
                loginButton.heightAnchor.constraint(equalToConstant: 62),
                loginButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -33)
            ])
        } else {
            NSLayoutConstraint.activate([
                logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35),
                logoImageView.heightAnchor.constraint(equalToConstant: 70),
                logoImageView.widthAnchor.constraint(equalToConstant: 125),
                
                userTextField.heightAnchor.constraint(equalToConstant: 50),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                
                stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                
                loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 86),
                loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -86),
                loginButton.heightAnchor.constraint(equalToConstant: 62),
                loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -33)
            ])
        }
    }
    
    //MARK: Alert / ActivityIndicator
    func showLoginFailureAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        showDetailViewController(alertController, sender: nil)
    }
    
    func showLoading() {
        loadingView.show()
    }
    
    func hideLoading() {
        loadingView.hide()
    }
}

//MARK: Extensions
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField {
            userTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        
        else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
