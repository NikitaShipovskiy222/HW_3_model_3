//
//  NoteManager.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 16/06/2024.
//

import Foundation
import Firebase
import FirebaseStorage

class NoteManager {
    
    func creatNote(text: String, header: String) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        let noteData: [String: Any] = [
            "note": text,
            "date": Date(),
            "header": header
            
        ]
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("note")
            .addDocument(data: noteData)
    }
    
    func getNote(complition: @escaping ([Note]) -> Void) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("note")
            .order(by: "date", descending: true)
            .addSnapshotListener { snap, error in
                guard error == nil else {return}
                
                var note: [Note] = []
                
                if let documents = snap?.documents {
                    documents.forEach {
                        
                        let docId = $0.documentID
                        let timeStamp = $0["date"] as? Timestamp
                        let date = timeStamp?.dateValue()
                        let noteText = $0["note"] as? String
                        let noteHeader = $0["header"] as? String
                        
                        let oneNote: Note = Note(id: docId, date: date, note: noteText, header: noteHeader)
                        note.append(oneNote)
                    }
                }
                
                complition(note)
            }
        
        
            func loadImageURL(complition: @escaping (Result<URL, Error>) -> Void){
                guard let uid = SingltonModel.shared.userId else {return}
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .getDocument { snap, error in
                        guard error == nil else {
                            complition(.failure(error!))
                            return
                        }
        
                        if let document = snap {
                            if let urlString = document["noteImageUrl"] as? String,
                               let url = URL(string: urlString) {
                                complition(.success(url))
                            }
                        }
                    }
            }
        
    }
    
    func setNoteImage(urlString: String) {
        guard let uid = SingltonModel.shared.userId else {return}
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .updateData(["noteImageUrl": urlString])
        
    }
    
    func uploadOneImage(image: Data?, storageLink: StorageReference, complition: @escaping (Result<URL, Error>) -> Void) {
        
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
        let ref = Storage.storage().reference().child(uid + "/noteImage/").child(imageName)
        
        self.uploadOneImage(image: imageData, storageLink: ref) { [weak self] result in
            guard let self = self else {return}

            
            switch result {
            case .success(let url):
                self.setNoteImage(urlString: url.absoluteString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func deleteNote(id: String) {
        guard let uid = SingltonModel.shared.userId else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("note")
            .document(id)
            .delete()

       }
    
    
}

    
    
struct Note {
    
    let id: String
    let date: Date?
    let note: String?
    let header: String?
    
    
}
