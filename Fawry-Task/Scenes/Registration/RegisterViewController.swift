//
//  RegisterViewController.swift
//  Fawry-Task
//
//  Created by Labeeb on 26/11/2021.
//

import UIKit

protocol RegisterPageDelegate {
    func didRegisterSuccessfully(with mobile : String)
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confitmPasswordTextField: UITextField!
    @IBOutlet var roundedViews: [UIView]!
    
    var viewModel: RegisterViewModel?
    var delegate: RegisterPageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupObservers()
    }
    
    func setupUI() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        mobileTextField.keyboardType = .asciiCapableNumberPad
        for view in roundedViews {
            view.layer.cornerRadius = 8
        }
    }
    
    func setupViewModel() {
        viewModel = RegisterViewModel.init()
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
    
    @IBAction func registerUserButtonTapped(_ sender: Any) {
        viewModel?.register(with: mobileTextField.text!, password: passwordTextField.text!, confirmPassword: confitmPasswordTextField.text!, success: { user in
            navBackToLogin(user: user)
        }, failure: { error in
            alertWith(error: error.description())
        })
    }
    
    func navBackToLogin(user: UserModel) {
        delegate?.didRegisterSuccessfully(with: user.mobile)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}
