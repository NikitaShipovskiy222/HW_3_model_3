//
//  RegistrModel.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


//MARK: - RegistrModel
final class RegistrModel {
    func userRegistration(userData: UserRegData, complition: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.passcode) { result, error in
            guard error == nil else {
                complition(.failure(error!))
                return
            }
    
            if let uid = result?.user.uid {
                result?.user.sendEmailVerification()
                self.setUserData(uid: uid, name: userData.name, email: userData.email, dateB: userData.dateB)
                complition(.success(true))
            }
        }
    }
    
    func setUserData(uid: String, name: String, email: String, dateB: Date) {
        
        let ref = Firestore.firestore()
            .collection("users")
            .document(uid)
        
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "HB": dateB,
            "isActivate": true
        ]
        
            ref.setData(userData) { error in
                print("is Activ")
                
        }
    }
}
    
//MARK: UserRegData
    struct UserRegData {
        
        let name: String
        let email: String
        let passcode: String
        let dateB: Date
        
    }
    

