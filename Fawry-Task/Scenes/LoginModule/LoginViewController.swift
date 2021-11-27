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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        mobileTextField.keyboardType = .asciiCapable
        for view in roundedViews {
            view.layer.cornerRadius = 8
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func showPasswordTapped(_ sender: Any) {
    }
    
}
