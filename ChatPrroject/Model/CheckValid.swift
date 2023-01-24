//
//  CheckValid.swift
import Foundation

class CheakValid {
    
    func validRegister(name: String, email: String, password: String) -> Bool {
        if (name != "" && email != "" && password != "") {
            return true
        } else {
            return false
        }
    }
    
    func validAuth(email: String, password: String) -> Bool {
        if (email != "" && password != "") {
            return true
        } else {
            return false
        }
    }
    
    static var shared: CheakValid = {
        let instance = CheakValid()
        return instance
    }()
    
    private init() {}
}
