//
//  DesignableView.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 02/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    private static var _addShadow:Bool = false
    
    @IBInspectable var addShadow:Bool {
        get {
            return UIView._addShadow
        }
        set(newValue) {
            if(newValue == true){
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.2
                layer.shadowOffset = CGSize(width: 0, height: 3)
                layer.shadowRadius = 10
                
                layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale =  UIScreen.main.scale
            }
        }
    }
}
