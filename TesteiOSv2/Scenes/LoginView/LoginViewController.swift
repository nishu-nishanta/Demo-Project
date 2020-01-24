//
//  LoginViewController.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

protocol LoginDisplayLogic: class
{
    func displayLogin(viewModel: Login.LoginFormFields.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic, UIGestureRecognizerDelegate
{
    @IBOutlet weak var UserLoginTextField: UITextField!
    @IBOutlet weak var PasswordTestField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var tapGesture = UITapGestureRecognizer()
    
    
    
    // MARK: Object lifecycle Methods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
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
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.configureFields()
        activityIndicator.isHidden = true
    }
    
    // MARK: Validation Methods for login
    func checkUserRules() -> Bool {
        var retStatus = false
        if let user = UserLoginTextField.text, !user.isEmpty {
            if !user.isNumeric {
                if !isValidEmail(user)
                {
                    messageLabel.text = Message.emailError.rawValue
                } else {
                    retStatus = true
                }
            } else {
                if user.count != 11 {
                    messageLabel.text = Message.passwordError.rawValue
                } else {
                    retStatus = true
                }
            }
        } else {
            messageLabel.text = "Please enter user."
        }
        return retStatus
    }
    
    func checkPasswordRules() -> Bool {
        var retStatus = false
        if let passwd = PasswordTestField.text, !passwd.isEmpty {
            let capitalLetterRegEx  = ".*[A-Z]+.*"
            let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
            guard texttest.evaluate(with: passwd) else
            {
                messageLabel.text = Message.capitalLetterrror.rawValue
                return false
            }
            let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
            let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
            guard texttest2.evaluate(with: passwd) else
            {
                messageLabel.text = Message.specialCharError.rawValue
                return false
            }
            
            if (passwd.letterCount >= 1) || passwd.digitCount >= 1 {
                retStatus = true
            } else {
                messageLabel.text = Message.alphanumericError.rawValue
            }
        } else {
            messageLabel.text = "Enter password!!"
        }
        return retStatus
    }
    
    //MARK: Login button action method
    
    @IBAction func doLogin(_ sender: Any) {
        
        let user = UserLoginTextField.text ?? ""
        let password = PasswordTestField.text ?? ""
        let request = Login.LoginFormFields.Request(user: user, password: password)
        messageLabel.text = ""
        
        if checkUserRules() && checkPasswordRules(){
            let saveSuccessful: Bool = KeychainWrapper.standard.set(user, forKey: "userStringKey")
            print("Save was successful: \(saveSuccessful)")
            messageLabel.text = "Please wait..."
            interactor?.doLogin(request: request)
        }
    }
    
    
    
    func configureFields() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        UserLoginTextField.borderStyle = UITextBorderStyle.roundedRect
        PasswordTestField.borderStyle = UITextBorderStyle.roundedRect
        PasswordTestField.clearsOnBeginEditing = false
        
        messageLabel.text = ""
        
        if let retrievedUser = KeychainWrapper.standard.string(forKey: "userStringKey"), !retrievedUser.isEmpty {
            UserLoginTextField.text = retrievedUser
        }
        
        PasswordTestField.text = ""
    }
    
    func displayLogin(viewModel: Login.LoginFormFields.ViewModel)
    {
        if viewModel.success {
            showGreeting(greeting: viewModel.greeting)
            activityIndicator.isHidden = false
            activityIndicator.center = self.view.center
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.router?.routeToShowUserData(segue: nil)
            }
        } else {
            showErrors(greeting: viewModel.greeting)
        }
    }
    
    func showGreeting(greeting: String)
    {
        messageLabel.text = greeting
    }
    
    func showErrors(greeting: String)
    {
        messageLabel.text = greeting
    }
    
    func isValidEmail(_ emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    @objc func clickView(_ sender: UIView) {
        view.endEditing(true)
    }    
}

//MARK: Extension method for login view controller

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        view.removeGestureRecognizer(tapGesture)
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        self.view.endEditing(true)
        view.addGestureRecognizer(tapGesture)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString stringDigitada: String) -> Bool {
        print("shouldChangeCharactersIn")
        return true
    }
}


