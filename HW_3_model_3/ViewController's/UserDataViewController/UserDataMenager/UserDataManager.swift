//
//  UserDataManager.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 24/06/2024.
//

import Foundation
import Firebase
import FirebaseStorage


class UserDataManager {
    
    func setNameUser(complition: @escaping (String) -> Void){
        guard let uid = SingltonModel.shared.userId else {return}
        
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snap, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                let nameString = snap?["name"] as? String
                complition(nameString ?? "")
            }
        
    }
    
    
    func setEmailUser(complition: @escaping (String) -> Void) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snap, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                let emailString = snap?["email"] as? String
                complition(emailString ?? "")
            }
    }
    
    func setHBUser(complition: @escaping (Date) -> Void) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .updateData(["HB":Date()])
    }
    
    private func uploadOneImage(image: Data?, storageLink: StorageReference, complition: @escaping (Result<URL, Error>) -> Void) {
        
        let mateData = StorageMetadata()
        mateData.contentType = "image/jpeg"
        
        guard let imageData = image else {return}
        
        storageLink.putData(imageData, metadata: mateData) { meta, error in
            guard error == nil else {
                complition(.failure(error!))
                return
            }
            storageLink.downloadURL { url, error in
                guard error == nil else {
                    complition(.failure(error!))
                    return
                }
                
                guard let url = url else {
                    complition(.failure(error!))
                    return
                }
                complition(.success(url))
            }
        }.observe(.progress) { snapShot in
            print(snapShot.progress?.completedUnitCount ?? "")
        }
    }
    
    
    func uploadImage(imageData: Data) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        let imageName = UUID().uuidString + ".jpeg"
        let ref = Storage.storage().reference().child(uid + "/avtars/").child(imageName)
        
        
        self.uploadOneImage(image: imageData, storageLink: ref) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let url):
                self.setUserAvatar(urlString: url.absoluteString)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUserAvatar(urlString: String) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .updateData(["avatarUrl": urlString])
        
    }
}
