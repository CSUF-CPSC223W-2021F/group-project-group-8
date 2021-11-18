//
//  Utilities.swift
//  Scheduler
//
//  Created by Badillo, Nancy on 11/18/21.
//

import Foundation
import UIKit

class Utilities {
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTested = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTested.evaluate(with: password)
    }
}
