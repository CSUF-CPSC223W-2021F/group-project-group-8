//
//  Login.swift
//  Scheduler
//
//  Created by Badillo, Nancy on 10/7/21.
//

import Foundation

struct Login {
    var username: String = ""
    var password: String = ""
    
    init?(username: String?, password: String?){
        guard let username = username, let password = password else {
            return nil
        }
        self.username = username  // setting to current user name
        self.password = password  // setting to current password
    }
    
    var verify: Bool {
        guard username.isEmpty == false && password.isEmpty == false else {
            return false
        }
        return true
    }
}
