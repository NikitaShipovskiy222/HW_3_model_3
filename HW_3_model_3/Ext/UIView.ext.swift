//
//  UIView.ext.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import Foundation
import UIKit

//MARK: - extension UIView
extension UIView {
    static func config<T: UIView>(view: T, completion: @escaping (T) -> Void) -> T {
        view.translatesAutoresizingMaskIntoConstraints = false
        completion(view)
        return view
    }
}


extension UIView {
    func addAllViews(_ add: UIView...) {
        add.forEach{
            self.addSubview($0)
        }
    }
}
