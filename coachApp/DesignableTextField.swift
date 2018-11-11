//
//  DesignableTextField.swift
//  Dashboard_Prof
//
//  Created by ESPRIT on 13/03/2018.
//  Copyright © 2018 Lilia. All rights reserved.
//

import UIKit


@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftImage {
            leftViewMode = .always
            let imageview = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageview.image = image
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none ||
                borderStyle == UITextBorderStyle.line {
                width = width+5
                
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageview)
            
            leftView = view
        }else {
            //image is nil
            leftViewMode = .never
        }
    }
    
}


