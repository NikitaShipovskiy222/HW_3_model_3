//
//  UIStackView.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import UIKit


//MARK: - extension UIStackView
extension UIStackView {
    
    static func makeStack(addName: UIView = .init(), addEmail: UIView, addPasscode: UIView) -> UIStackView {
        {
            .config(view: $0) { stack in
                [addName, addEmail, addPasscode].forEach{
                    stack.addArrangedSubview($0)
                }
                stack.distribution = .fillEqually
                stack.spacing = 10
                stack.axis = .vertical
                stack.heightAnchor.constraint(equalToConstant: 246).isActive = true
            }
        }(UIStackView())
    }
}
