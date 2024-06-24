//
//  LoginModel.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 10/06/2024.
//

import Foundation
import FirebaseAuth


//MARK: - LoginModel
final class LoginModel {
    
    func loginIn(userData: LoginUserData, complition: @escaping (Result<UserVerification, Error>) -> Void){
        Auth.auth().signIn(withEmail: userData.email, password: userData.passcode) { result, error in
            guard error == nil else {
                complition(.failure(error!))
                return
            }
            
            if let isVerify =  result?.user.isEmailVerified, isVerify {
                complition(.success(.verification))
            } else {
                complition(.success(.noVerification))
            }
        }
    }
}

//MARK: LoginUserData
struct LoginUserData {
    let email: String
    let passcode: String
}

//MARK: UserVerification
enum UserVerification {
    case verification , noVerification
}
