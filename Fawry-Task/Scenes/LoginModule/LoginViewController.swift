//
//  LoginViewController.swift
//  Fawry-Task
//
//  Created by Labeeb on 26/11/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var roundedViews: [UIView]!
    
    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupObservers()
        
        #if DEBUG
        mobileTextField.text = "01123654789"
        passwordTextField.text = "4789678691"
        #endif
    }
    
    func setupUI() {
        
        mobileTextField.keyboardType = .asciiCapable
        for view in roundedViews {
            view.layer.cornerRadius = 8
        }
    }
    
    func setupViewModel() {
        viewModel = LoginViewModel.init()
    }
    
    func setupObservers() {
        _ = viewModel?.errorMessage?.subscribe({[weak self] event in
            switch event {
            case .next(let message):
                guard let message = message else{
                    return
                }
                self?.alertWith(error: message)
            default:
                break
            }
        })
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let mobile = mobileTextField.text!
        let password = passwordTextField.text!
        viewModel?.login(with: mobile, password: password, success: { user in
            navigateToVC(with: user)
        }, failure: { error in
            alertWith(error: error.description())
        })
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let vc = RegisterViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertWith(error: String) {
        let alert = UIAlertController.init(title: nil, message: error, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func navigateToVC(with user: UserModel) {
        let vc = HomeViewController.init()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    
    
    @IBAction func showPasswordTapped(_ sender: UIButton) {
        if sender.isSelected {
            passwordTextField.isSecureTextEntry = true
        }else {
            passwordTextField.isSecureTextEntry = false
        }
        sender.isSelected = !sender.isSelected
    }
    
}
