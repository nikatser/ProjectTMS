import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    //MARK: -- Authorization and Registration
    
    func createNewUser(_ data: LoginField, name: String, complition: @escaping (ResponceCode) -> ()) {
        Auth.auth()
            .createUser(withEmail: data.email, password: data.password) {[weak self] result, err in
                if err == nil {
                    if result != nil {
                        let userId = result?.user.uid
                        let email = data.email
                        Firestore.firestore().collection("users").document(userId!).setData(["email" : email,
                                                                                             "name" : name])
                        complition(ResponceCode(code: 1))
                    }
                } else {
                    complition(ResponceCode(code: 0))
                }
            }
    }
    
    func authApp(_ data: LoginField, complition: @escaping (ResponceCode) -> ()) {
        Auth.auth()
            .signIn(withEmail: data.email, password: data.password) { result, err in
                if err != nil {
                    print(err?.localizedDescription as Any)
                } else {
                    complition(ResponceCode(code: 1))
                }
            }
    }
    
    //MARK: -- People
    
    func getAllUsers(complition: @escaping ([CurrentUser]) -> ()) {
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var currentUsers = [CurrentUser]()
        Firestore.firestore()
            .collection("users")
            .whereField("email", isNotEqualTo: email)
            .getDocuments() {
                snap, err in
                if err == nil {
                    if let docs = snap?.documents {
                        for doc in docs{
                            let data = doc.data()
                            let userID = doc.documentID
                            let name = data["name"] as! String
                            currentUsers.append(CurrentUser(userID: userID, name: name))
                            print(name)
                        }
                    }
                    complition(currentUsers)
                }
            }
    }
    
    //MARK: -- Messange
    
    func sendMessage(otherID: String, conversationID: String?, text: String, complition: @escaping (String)->()) {
        
        if let userID = Auth.auth().currentUser?.uid {
            
            if conversationID == nil {
                
                let conversationID = UUID().uuidString
                let selfData: [String : Any] = [
                    "date" : Date(),
                    "otherID" : otherID
                ]
                let otherData: [String : Any] = [
                    "date" : Date(),
                    "otherID" : userID
                ]
                
                Firestore.firestore().collection("users")
                    .document(userID)
                    .collection("conversations")
                    .document(conversationID)
                    .setData(selfData)
                
                Firestore.firestore().collection("users")
                    .document(otherID)
                    .collection("conversations")
                    .document(conversationID)
                    .setData(otherData)
                
                let msg: [String : Any] = [
                    "date" : Date(),
                    "sender" : userID,
                    "text" : text,
                ]
                
                let conversationDescription: [String : Any] = [
                    "date" : Date(),
                    "firstSenderID" : userID,
                    "secondSenderID" : otherID,
                ]
                
                Firestore.firestore().collection("conversations")
                    .document(conversationID)
                    .setData(conversationDescription)
                
                Firestore.firestore().collection("conversations")
                    .document(conversationID)
                    .collection("messages")
                    .addDocument(data: msg) { err in
                        if err == nil {
                            complition(conversationID)
                        } else {
                            complition(conversationID)
                        }
                    }
                
            } else {
                
                let msg: [String : Any] = [
                    "date" : Date(),
                    "sender" : userID,
                    "text" : text,
                ]
                
                Firestore.firestore().collection("conversations")
                    .document(conversationID!)
                    .collection("messages")
                    .addDocument(data: msg) { err in
                        if err == nil {
                            complition(conversationID!)
                        }
                    }
            }
        }
    }
    
    func getAllChats(complition: @escaping ([(String, String, String)]) -> ()){
        if let userID = Auth.auth().currentUser?.uid {
            var currentUsers = [(String, String,String)]()
            Firestore.firestore().collection("users")
                .document(userID)
                .collection("conversations")
                .getDocuments { snap, err in
                    if err == nil  {
                        if let docs = snap?.documents {
                            for doc in docs{
                                let data = doc.data()
                                let otherID = data["otherID"] as! String
                                let date = data["date"] as! Timestamp
                                currentUsers.append((doc.documentID, otherID, "\(date)"))
                            }
                        }
                        complition(currentUsers)
                    }
                }
        }
    }
    
    func getConversationId(otherID: String, complition: @escaping (String)->()) {
        if let userID = Auth.auth().currentUser?.uid {
            
            Firestore.firestore().collection("users")
                .document(userID)
                .collection("conversations")
                .whereField("otherID", isEqualTo: otherID)
                .getDocuments() { snap, err in
                    if err == nil {
                        if let snap = snap {
                            if let doc = snap.documents.first {
                                complition(doc.documentID)
                            }
                        }
                    }
                }
            
        }
    }
            
    
    func getAllMessages(chatID: String, complition: @escaping ([Message])->()) {
        if let userID = Auth.auth().currentUser?.uid {
            
            Firestore.firestore().collection("conversations")
                .document(chatID)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false)
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty {
                        var msgs = [Message]()
                        var sender = Sender(senderId: userID, displayName: "Me")
                        for doc in snap.documents {
                            let data = doc.data()
                            let uid = data["sender"] as! String
                            if uid == userID {
                                sender = Sender(senderId: "1", displayName: "me")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            let messageID = doc.documentID
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            //sender = Sender(senderId: uid, displayName: "me")
                            msgs.append(Message(sender: sender, messageId: messageID, sentDate: sentDate, kind: .text(text)))
                        }
                        complition(msgs)
                    }
                    
                }
        }
    }
    
}

