//
//  ForgetPasswordViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 16/06/2024.
//

import UIKit


//MARK: - ForgetPasswordViewController
final class ForgetPasswordViewController: UIViewController {
    
    private let removePasscode = ForgetPasscodeModel()
    
    private lazy var makeBackgroundImage: UIImageView = {
        $0.image = .fon
        return $0
    }(UIImageView(frame: view.frame))
    
   private lazy var labelForget = UILabel.makeLabel(text: "Сброс пароля")
    
    
    private lazy var textFiledEmail = UITextField.makeTextFiled(x: 30, y: 370 , width: view.frame.width - 60, placeholder: "Введите почту", eye: UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 1)), corrextion: .no)
    

    private lazy var buttoAccept = UIButton.makeNextButton(title: "Сбросить пароль", action: actionRemovePasscode, backgroundColor: .black, titleColor: .main)
    
    
    private lazy var xButton: UIButton = {
        .config(view: $0) { button in
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.heightAnchor.constraint(equalToConstant: 20).isActive = true
            button.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button.tintColor = .main
        }
    }(UIButton(primaryAction: xAction))
    
    lazy var xAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        self.dismiss(animated: true, completion: nil)
    }
    
    
    lazy var actionRemovePasscode = UIAction { [weak self] _ in
        guard let self = self else {return}
        let email = textFiledEmail.text!
        if(!email.isEmpty) {
            removePasscode.forgetPasscode(email: email) { result in
                switch result {
                case .success(let success):
                    let alert = UIAlertController(title: "Проверте свою почту", message: "Вы сбросили пароль", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default) { _ in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAllAlert(okButton)
                    self.present(alert, animated: true)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addAllViews(makeBackgroundImage, labelForget, textFiledEmail, buttoAccept, xButton)
        

        makeConstraint()
        
        
    }
    
    func makeConstraint() {
        NSLayoutConstraint.activate([
            xButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            xButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            labelForget.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            labelForget.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            
            textFiledEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textFiledEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textFiledEmail.topAnchor.constraint(equalTo: labelForget.topAnchor, constant: 50),
            
            buttoAccept.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttoAccept.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttoAccept.topAnchor.constraint(equalTo: textFiledEmail.bottomAnchor, constant: 100),
        
        ])
    }
    


}
