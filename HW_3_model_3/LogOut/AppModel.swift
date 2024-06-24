//
//  AppModel.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 10/06/2024.
//

import Foundation
import FirebaseAuth

//MARK: - AppModel
class AppModel {
    func isUserLogin() -> Bool {
        if let _ = Auth.auth().currentUser?.uid {
            return true
        } else {
            return false
        }
    }
    
    //MARK: logOut
    func logOut(){
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: NSNotification.Name("setRoot"), object: nil, userInfo: ["vc":"login"])
        } catch {
            print(error.localizedDescription)
        }
    }
}
