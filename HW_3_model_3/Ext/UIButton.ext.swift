//
//  UIButton.ext.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import UIKit


//MARK: - extension UIButton
extension UIButton {
    static func makeNextButton(title: String, action: UIAction, backgroundColor: UIColor = .clear, titleColor: UIColor = .black) -> UIButton {
        {
            .config(view: $0) { btn in
                btn.setTitle(title, for: .normal)
                btn.backgroundColor = backgroundColor
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                btn.setTitleColor(titleColor, for: .normal)
                btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                btn.layer.cornerRadius = 10
            }
        }(UIButton(primaryAction: action))
    }
}


