//
//  ViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import UIKit

//MARK: - LoginViewController
final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let eyeButton = EyeButton()
    private var isPrivate = true
    private let loginModel = LoginModel()
    var userEmail: String = ""
    var userPasscode: String = ""
    
    private lazy var makeBackgroundImage: UIImageView = {
        $0.image = .fon
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)))
    
    private lazy var registLabel = UILabel.makeLabel(text: "Войти")
    
    
    private lazy var vStack: UIStackView = {
        .config(view: $0) { [weak self] stack in
            guard let self = self else {return}
            stack.spacing = 10
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.heightAnchor.constraint(equalToConstant: 150).isActive = true
            [self.emailTextFiled, self.passcodeTextFiled].forEach{
                stack.addArrangedSubview($0)
            }
        }
    }(UIStackView())

    
    private lazy var emailTextFiled = UITextField.makeTextFiled(placeholder: "Почта", eye: UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 1)), corrextion: .no)
    private lazy var passcodeTextFiled = UITextField.makeTextFiled(placeholder: "Пароль", passcode: true, eye: eyeButton, corrextion: .no)
    

    private lazy var makeNextButton = UIButton.makeNextButton(title: "Войти", action: nextAction, backgroundColor: .main)
    
    lazy var nextAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        let loginUserData: LoginUserData = LoginUserData(email: self.userEmail , passcode: self.userPasscode)
        loginModel.loginIn(userData: loginUserData) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                switch success{
                case .verification:
                    NotificationCenter.default.post(Notification(name: Notification.Name("setRoot"), userInfo: ["vc":"tabBar"]))
                case .noVerification:
                    let alert = UIAlertController(title: "Ошибка", message: "Вы не верефицированы", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default) { _ in
                        print("ok")
                    }
                    let cancelButton = UIAlertAction(title: "Закрыть", style: .cancel) { _ in
                        print("Закрыть")
                    }
                    alert.addAllAlert(okButton, cancelButton)
                    self.present(alert, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        userEmail = emailTextFiled.text!
        userPasscode = passcodeTextFiled.text!
    }

    private lazy var makeLilButton = UIButton.makeNextButton(title: "Регестрация", action: lilButtonAction, titleColor: .main)
    
    private lazy var youHaveAccLabel = UILabel.makeLilLabel(text: "У вас ещё нет аккаунта?", color: .black, weightText: .regular)
    
    lazy var lilButtonAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        NotificationCenter.default.post(Notification(name: Notification.Name("setRoot"), userInfo: ["vc":""]))
    }
    

    private lazy var buttonForgetPasscode = UIButton.makeNextButton(title: "Забыл пароль?", action: forgetPasscodeAction)
    
    lazy var forgetPasscodeAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        present(ForgetPasswordViewController(), animated: true)
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addAllViews(makeBackgroundImage, registLabel, vStack, makeNextButton, youHaveAccLabel, makeLilButton, buttonForgetPasscode)
        addAction()
        allConstraint()
        
    }
    
    func addAction() {
        eyeButton.addTarget(self, action: #selector(displayBookMark), for: .touchUpInside)
        
    }

    @objc private func displayBookMark() {
        let imageName = isPrivate ? "eye.fill" : "eye.slash.fill"
        passcodeTextFiled.isSecureTextEntry.toggle()
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        isPrivate.toggle()
    }
    
    //MARK: AllConstraint
    func allConstraint() {
        NSLayoutConstraint.activate([
            registLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 279),
            
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            vStack.topAnchor.constraint(equalTo: registLabel.bottomAnchor, constant: 50),
            
            
            makeNextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            makeNextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            makeNextButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 250),
            
            
            youHaveAccLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 120),
            youHaveAccLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            youHaveAccLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            
            makeLilButton.topAnchor.constraint(equalTo: youHaveAccLabel.topAnchor, constant: -10),
            makeLilButton.leadingAnchor.constraint(equalTo: youHaveAccLabel.trailingAnchor, constant: -55),
            
            buttonForgetPasscode.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 30),
            buttonForgetPasscode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonForgetPasscode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)

        ])

    }

}

