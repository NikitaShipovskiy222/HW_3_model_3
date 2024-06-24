//
//  ViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import UIKit

//MARK: - RegistrationViewController
final class RegistrationViewController: UIViewController {
    
    private let eyeButton = EyeButton()
    private var isPrivate = true
    private let regModel = RegistrModel()
    
    
    var userName: String = ""
    var userEmail: String = ""
    var userPasscode: String = ""
    var userDateB: Date?
    
    private lazy var makeBackgroundImage: UIImageView = {
        $0.image = .fon
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)))
    
    
    private lazy var registLabel = UILabel.makeLabel(text: "Регистрация")
    
    
    private lazy var vStack = UIStackView.makeStack(addName: self.nameTextFiled, addEmail: self.emailTextFiled, addPasscode: self.passcodeTextFiled)
    
    
    private lazy var nameTextFiled = UITextField.makeTextFiled(placeholder: "Имя", eye: UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 1)), corrextion: .yes)
    private lazy var emailTextFiled = UITextField.makeTextFiled(placeholder: "Почта", eye: UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 1)), corrextion: .no)
    private lazy var passcodeTextFiled = UITextField.makeTextFiled(placeholder: "Пароль", passcode: true, eye: eyeButton, corrextion: .no)
    

    private lazy var makeNextButton = UIButton.makeNextButton(title: "Войти", action: nextAction, backgroundColor: .main)
    
    private lazy var youHaveAccLabel = UILabel.makeLilLabel(text: "У вас уже есть аккаунт?", color: .black, weightText: .regular)
    
    
    lazy var nextAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        let userData = UserRegData(name: self.userName,
                                   email: self.userEmail,
                                   passcode: self.userPasscode,
                                   dateB: self.userDateB ?? Date())
        self.regModel.userRegistration(userData: userData) { result in
            switch result {
            case .success(let success):
                if success {
                    NotificationCenter.default.post(Notification(name: Notification.Name("setRoot"), userInfo: ["vc":"login"]))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        userName = nameTextFiled.text!
        userEmail = emailTextFiled.text!
        userPasscode = passcodeTextFiled.text!
    }

    private lazy var makeLilButton = UIButton.makeNextButton(title: "Войти", action: lilButtonAction, titleColor: .main)
    
    lazy var lilButtonAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        NotificationCenter.default.post(Notification(name: Notification.Name("setRoot"), userInfo: ["vc":"login"]))
    }
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addAllViews(makeBackgroundImage, registLabel, vStack, makeNextButton, youHaveAccLabel, makeLilButton)
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
    
    
    func allConstraint() {
        NSLayoutConstraint.activate([
            registLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 279),
            
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            vStack.topAnchor.constraint(equalTo: registLabel.bottomAnchor, constant: 20),
            
            
            makeNextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            makeNextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            makeNextButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 200),
            
            youHaveAccLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 60),
            youHaveAccLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            youHaveAccLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            
            makeLilButton.topAnchor.constraint(equalTo: youHaveAccLabel.topAnchor, constant: -10),
            makeLilButton.leadingAnchor.constraint(equalTo: youHaveAccLabel.trailingAnchor, constant: -55),
            
        ])
    }
}




