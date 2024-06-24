//
//  LookNoteViewController.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 23/06/2024.
//

import UIKit

final class LookNoteViewController: UIViewController {

    
    var nameTitle: String?
    var titleImage: Data?
    var mainText: String?

    lazy var headerLabel1: UILabel = {
        .config(view: $0) { [weak self] label in
            guard let self = self else {return}
            label.text = self.nameTitle
            label.textColor = .main
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        }
    }(UILabel())
    
    lazy var mainTextNote: UILabel = {
        .config(view: $0) { [weak self] label in
            guard let self = self else {return}
            label.text = mainText
            label.textColor = .main
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }(UILabel())
                    
    lazy var imageNote: UIImageView = {
        .config(view: $0) { [weak self] image in
            guard let self = self else {return}
            
            image.image = UIImage(data: titleImage ?? Data())
            image.heightAnchor.constraint(equalToConstant: 150).isActive = true
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 15
        }
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonDisplayMode = .minimal
        view.addAllViews(imageNote, headerLabel1, mainTextNote)
        allConstraint()
        
    }
    
    func allConstraint() {
        NSLayoutConstraint.activate([
            headerLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            mainTextNote.topAnchor.constraint(equalTo: headerLabel1.bottomAnchor, constant: 50),
            mainTextNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainTextNote.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageNote.topAnchor.constraint(equalTo: mainTextNote.bottomAnchor, constant: 50),
            imageNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageNote.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    

}
