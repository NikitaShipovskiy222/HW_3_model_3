//
//  UITextFiled.ext.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import Foundation
import UIKit

//MARK: - extension UITextField
extension UITextField {
    
    static func makeTextFiled(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 70, placeholder: String, passcode: Bool = false, eye: UIView, corrextion: UITextAutocorrectionType) -> UITextField {
        
        {
            $0.placeholder = placeholder
            $0.isSecureTextEntry = passcode
            $0.layer.cornerRadius = 15
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 1))
            $0.leftViewMode = .always
            $0.rightView = eye
            $0.rightViewMode = .always
            $0.backgroundColor = .white
            $0.autocorrectionType = corrextion
            return $0
        }(UITextField(frame: CGRect(x: x, y: y, width: width, height: height)))
        
    }
}
