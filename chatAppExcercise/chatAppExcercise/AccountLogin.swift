//
//  AccountLogin.swift
//  chatAppExcercise
//
//  Created by Rohan Shah on 9/24/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class AccountLogin: NSObject {
   
    var userName: String
    var password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
        
        println("inside contructor  \(self.userName)")
    }
}
