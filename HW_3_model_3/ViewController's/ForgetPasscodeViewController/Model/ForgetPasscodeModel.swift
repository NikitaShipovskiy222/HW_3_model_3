//
//  ForgetPasscodeModel.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 17/06/2024.
//

import Foundation
import FirebaseAuth


final class ForgetPasscodeModel {
    
    func forgetPasscode(email: String, complition: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                complition(.failure(error!))
                return
            }
            if let error = error {
                complition(.failure(error))
            } else {
                complition(.success(true))
            }

        }
    }
}
