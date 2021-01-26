//
//  LoginViewController.swift
//  RxSwiftTest
//
//  Created by Juan Capponi on 1/22/21.
//

import UIKit
import RxSwift


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
  
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        print("button tapped!!!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.usernamePublishSubject).disposed(by: disposeBag)
        
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordPublishSubject).disposed(by: disposeBag)
        
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginViewModel.isValid().map {$0 ? 1: 0.1}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
}

class LoginViewModel {
    let usernamePublishSubject = PublishSubject<String>()
    let passwordPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(usernamePublishSubject.asObservable().startWith(""), passwordPublishSubject.asObservable().startWith("")).map { (username, password)  in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }
}
