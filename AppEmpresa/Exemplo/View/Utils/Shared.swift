//
//  Shared.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 29/01/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class Shared: NSObject {
    static let sharedInstance = Shared()

    func textFieldLeftPadding(textFieldName: UITextField) {
        textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textFieldName.frame.height))
        textFieldName.leftViewMode = .always
        textFieldName.rightViewMode = .always
    }

    private override init() {

    }
}
