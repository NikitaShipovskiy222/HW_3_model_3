//
//  ProfileFirebaseManager.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 12/06/2024.
//

import Foundation
import Firebase
import FirebaseStorage

//MARK: - ProfileFirebaseManager
final class ProfileFirebaseManager {
    
    private func getUID() -> String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    func loadAvatarURL(complition: @escaping (Result<URL, Error>) -> Void){
        Firestore.firestore()
            .collection("users")
            .document(getUID())
            .getDocument { snap, error in
                guard error == nil else {
                    complition(.failure(error!))
                    return
                }
                
                if let document = snap {
                    if let urlString = document["avatarUrl"] as? String,
                       let url = URL(string: urlString) {
                        complition(.success(url))
                    }
                }
            }
    }
    
    func uploadImage(imageData: Data) {
        let imageName = UUID().uuidString + ".jpeg"
        let ref = Storage.storage().reference().child(getUID() + "/avtars/").child(imageName)
        
        
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
        Firestore.firestore()
            .collection("users")
            .document(getUID())
            .updateData(["avatarUrl": urlString])

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
    
    func setNameProfile(complition: @escaping (String) -> Void){
        
        Firestore.firestore()
            .collection("users")
            .document(getUID())
            .getDocument { snap, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                let nameString = snap?["name"] as? String
                complition(nameString ?? "")
            }

    }
    
    

}


