//
//  UIAlertController.ext.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 10/06/2024.
//

import UIKit

    
//MARK: - extension UIAlertController
extension UIAlertController {
    
    func addAllAlert(_ alerts: UIAlertAction...) {
        alerts.forEach{
            self.addAction($0)
        }
    }
}
