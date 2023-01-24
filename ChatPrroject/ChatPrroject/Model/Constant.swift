//
//  Constant.swift
//  ChatPrroject
//
//  Created by Veronika Katser on 16.01.23.
//

import Foundation
import UIKit

class Constant {
    var mainColor = #colorLiteral(red: 0.7818319798, green: 0.7275211215, blue: 0.6503289342, alpha: 1)
    var mainNameFont = "Times New Roman"
    static var shared: Constant = {
        let instance = Constant()
        return instance
    }()
    private init() {}
}

class SliderItem {
    static var descriptionLabelText: [String] = ["This application \nallows you to find and \nchat with your friends", "Stay always in touch", "Join us if you don't \nhave an account or \nlogin to your account"]
}
