//
//  Email.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 31/01/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class Email: UIView {

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
