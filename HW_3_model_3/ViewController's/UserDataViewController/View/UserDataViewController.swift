//
//  UserDataViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 16/06/2024.
//

import UIKit

final class UserDataViewController: UIViewController {

    
    private let userData = UserDataManager()
    private let profileModel = ProfileFirebaseManager()
    
    
    private lazy var yourData = UILabel.makeLilLabel(text: "Ваши данные", color: .main, weightText: .bold)
    
    private lazy var yourName = UILabel.makeLilLabel(text: "Имя:", color: .main, weightText: .bold)
    
    private lazy var  yourEmail = UILabel.makeLilLabel(text: "Ваша почта:", color: .main, weightText: .bold)
    
    private lazy var  yourImageProfile = UILabel.makeLilLabel(text: "Ваша фотография:", color: .main, weightText: .bold)

    private lazy var  yourHBProfile = UILabel.makeLilLabel(text: "Дата рождение:", color: .main, weightText: .bold)
    
    private lazy var datePicker: UIDatePicker = {
        .config(view: $0) { picker in
            picker.locale = .current
            picker.datePickerMode = .dateAndTime
            picker.preferredDatePickerStyle = .compact
            picker.tintColor = .main
            picker.datePickerMode = .date
            picker.backgroundColor = .gray
            picker.layer.cornerRadius = 15
            picker.clipsToBounds = true
        }
    }(UIDatePicker())
    
    
    private lazy var saveButton = UIButton.makeNextButton(title: "Сохранить", action: actionSave, titleColor: .main)
    
    lazy var actionSave = UIAction { [weak self] _ in
        guard let self = self else {return}
        print(self.datePicker.date)
        userData.setHBUser { [weak self] hb in
            self?.datePicker.date = hb
        }
    }
    
    
    private lazy var labelHB = UILabel.makeLabel(text: self.datePicker.date.description, textColor: .main)
        
    private lazy var labelEmailUser: UILabel = {
        .config(view: $0) { label in
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            label.textColor = .main
        }
    }(UILabel())
    
    private lazy var labelUserName: UILabel = {
        .config(view: $0) { name in
            name.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            name.textColor = .main
        }
    }(UILabel())
    
    private lazy var userImageView: UIImageView = {
        .config(view: $0) { [weak self] image in
            guard let self = self else {return}
            image.layer.cornerRadius = 15
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }(UIImageView())
    
    
    override func viewWillAppear(_ animated: Bool) {
        profileModel.loadAvatarURL { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                self.userImageView.sd_setImage(with: success)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .main
        view.addAllViews(yourData, yourName, yourEmail, yourImageProfile, yourHBProfile, labelEmailUser, labelUserName, userImageView, datePicker, saveButton, labelHB)
        allConstraint()
        getUserEmail() 
        getUserName()
        
        }
    

    
    func getUserName() {
        userData.setNameUser { [weak self] name in
            guard let self = self else {return}
            self.labelUserName.text = name
        }
    }
    
    func getUserEmail() {
        userData.setEmailUser { [weak self] email in
            guard let self = self else {return}
            self.labelEmailUser.text = email
        }
    }
    
    private func allConstraint() {
        NSLayoutConstraint.activate([
            yourData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yourData.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            yourName.topAnchor.constraint(equalTo: yourData.bottomAnchor, constant: 100),
            yourName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            labelUserName.topAnchor.constraint(equalTo: yourName.bottomAnchor, constant: 20),
            labelUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            yourEmail.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 20),
            yourEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            labelEmailUser.topAnchor.constraint(equalTo: yourEmail.bottomAnchor, constant: 20),
            labelEmailUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            yourImageProfile.topAnchor.constraint(equalTo: labelEmailUser.bottomAnchor, constant: 50),
            yourImageProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            userImageView.topAnchor.constraint(equalTo: yourImageProfile.bottomAnchor, constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        
            
            yourHBProfile.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            yourHBProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            
            datePicker.topAnchor.constraint(equalTo: yourHBProfile.bottomAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            
            
            labelHB.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            labelHB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            labelHB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            
        ])
    }
    
}
