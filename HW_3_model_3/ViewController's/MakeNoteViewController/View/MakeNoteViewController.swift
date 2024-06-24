//
//  MakeNoteViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 20/06/2024.
//

import UIKit

//MARK: - MakeNoteViewController
final class MakeNoteViewController: UIViewController {
    
    private let makeNoteModel = MakeNoteManager()
    var note: NoteProfile?

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
    
    
    private lazy var headerTextFiled = UITextField.makeTextFiled(x: 150, y: 125, width: view.frame.width - 200, height: 50, placeholder: "Введите заголовок", eye: UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 1)), corrextion: .yes)
    
    private lazy var noteTextView: UITextView = {
        .config(view: $0) { textView in
            textView.layer.cornerRadius = 15
            textView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            textView.inputView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 1))
        }
    }(UITextView())
    
    private lazy var saveButton = UIButton.makeNextButton(title: "Сохранить", action: actionSave, backgroundColor: .main)
    
    lazy var actionSave = UIAction { [weak self] _ in
        guard let self = self else {return}
        let textFiled = headerTextFiled.text
        let textView = noteTextView.text
        if let img = makeCircleImage.image {
            if let imageData = img.jpegData(compressionQuality: 0.1) {
                self.makeNoteModel.creatNote(text: textView ?? "", image: imageData, header: textFiled ?? "")
                
                self.dismiss(animated: true)
            }
        }
    }
    
    
    private lazy var imagePicker:  UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    @objc func makeAction() {
        present(imagePicker, animated: true)
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.addAllViews(makeCircleImage, headerTextFiled, noteTextView, saveButton)
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            
            
            makeCircleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            makeCircleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            noteTextView.topAnchor.constraint(equalTo: makeCircleImage.bottomAnchor, constant: 50),
            noteTextView.leadingAnchor.constraint(equalTo: makeCircleImage.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            
            
            saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])

    }
}

extension MakeNoteViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            
            self.makeCircleImage.image = image
            
            if let imageData = image.jpegData(compressionQuality: 0.1) {
                self.makeNoteModel.uploadImage(imageData: imageData)

            }
        }
        picker.dismiss(animated: true)
    }
}
