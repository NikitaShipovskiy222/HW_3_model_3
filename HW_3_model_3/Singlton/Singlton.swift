//
//  Singlton.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import Foundation
import FirebaseAuth


//MARK: - SingltonModel
class SingltonModel {
    static let shared = SingltonModel()
    private init(){}
    
    var nameUser: String = ""
    var emailUser: String = ""
    var passwordUser: String = ""
    
    var userId: String? {
        get {
            Auth.auth().currentUser?.uid
            
        }
    }
    
}
