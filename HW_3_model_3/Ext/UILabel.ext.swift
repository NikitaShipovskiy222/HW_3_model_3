//
//  UILabel.ext.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import Foundation
import UIKit

//MARK: - extension UILabel
extension UILabel {
    
    static func makeLabel(text: String, textColor: UIColor = .black) -> UILabel {
        {
            .config(view: $0) { label in
                label.text = text
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            }
        }(UILabel())
        
    }
    
}

extension UILabel {
    
    static func makeLilLabel(text: String, color: UIColor, weightText: UIFont.Weight ) -> UILabel {
        {
            .config(view: $0) { label in
                label.text = text
                label.font = UIFont.systemFont(ofSize: 20, weight: weightText)
                label.textColor = color
            }
        }(UILabel())
    }
}
