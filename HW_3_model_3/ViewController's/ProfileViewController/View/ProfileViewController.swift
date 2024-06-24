//
//  ProfileViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.

import UIKit
import SDWebImage

//MARK: - ProfileViewController
final class ProfileViewController: UIViewController {
    
    private let appModel = AppModel()
    private let profileModel = ProfileFirebaseManager()
    var note: NoteProfile?
   
        
    private lazy var label: UILabel = {
        .config(view: $0) { [weak self] label in
            guard let self = self else {return}
            
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .main
        }
    }(UILabel())
    
    private lazy var makeCircleImage: UIImageView = {
        .config(view: $0) { [weak self] image in
            guard let self = self else {return}
            image.backgroundColor = .main
            image.clipsToBounds = true
            image.widthAnchor.constraint(equalToConstant: 100).isActive = true
            image.heightAnchor.constraint(equalToConstant: 100).isActive = true
            image.isUserInteractionEnabled = true
            image.layer.borderColor = UIColor.main.cgColor
            image.layer.borderWidth = 3
            image.addGestureRecognizer(self.tapImage)
            image.layer.cornerRadius = 50
        }
    }(UIImageView())
    
    
    private lazy var tapImage = UITapGestureRecognizer(target: self, action: #selector(makeAction))
    
    
    private lazy var imagePicker:  UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    @objc func makeAction() {
        present(imagePicker, animated: true)
    }

    private lazy var makeExitButton = UIButton.makeNextButton(title: "Выйти", action: exitAction, backgroundColor: .main)
    
    lazy var exitAction = UIAction { [weak self] _ in
        
        guard let self = self else {return}
        self.appModel.logOut()
    }

    
    private lazy var buttonEdit = UIButton.makeNextButton(title: "Добавить заметку", action: editAction, backgroundColor: .main)
    
    lazy var editAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        let editVc = DitaelsScreenViewController()
        self.navigationController?.pushViewController(editVc, animated: true)
    }
    
    private lazy var buttonDataUser = UIButton.makeNextButton(title: "Данные профиля", action: dataUserAction, backgroundColor: .main)
    
    lazy var dataUserAction = UIAction { [weak self] _ in
        guard let self = self else {return}
        let userDataVC = UserDataViewController()
        
        self.navigationController?.pushViewController(userDataVC, animated: true)
    }
    
    private lazy var vStack = UIStackView.makeStack(addEmail: buttonEdit, addPasscode: buttonDataUser)
    
    override func viewWillAppear(_ animated: Bool) {
        profileModel.loadAvatarURL { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                self.makeCircleImage.sd_setImage(with: success)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addAllViews(label, makeCircleImage, makeExitButton, vStack)


        navigationItem.backButtonDisplayMode = .minimal

        allConstraint()
        getUserName()
    }
    
    func getUserName() {
        profileModel.setNameProfile { [weak self] name in
            guard let self = self else {return}
            self.label.text = name
        }
    }
    
    func allConstraint() {
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            makeCircleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            makeCircleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            makeExitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            makeExitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            makeExitButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            vStack.topAnchor.constraint(equalTo: makeExitButton.bottomAnchor, constant: 50),
            
        
        ])
    }

  
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            
            self.makeCircleImage.image = image
            
            if let imageData = image.jpegData(compressionQuality: 0.1) {
                self.profileModel.uploadImage(imageData: imageData)

            }
        }
        picker.dismiss(animated: true)
    }
}



