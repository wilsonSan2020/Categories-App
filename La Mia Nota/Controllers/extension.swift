//
//  extension.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

extension UIView {
    enum ViewSide {
        case left, right, bottom, top
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left:
            border.frame = CGRect(x: frame.minX, y:frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y:frame.minY, width: thickness, height: frame.height)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y:frame.maxY, width: frame.width, height: thickness)
        case .top:
            border.frame = CGRect(x: frame.minX, y:frame.minY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}

extension UIColor {
    
    static var primaryColor = UIColor.init(rgb: 0xE0BE53)
    static var headerGrayColor = UIColor.init(rgb: 0x8e8e93)
    static var superLightGrayColor = UIColor.init(rgb: 0xf4f7f9)
    static var superWhiteColor = UIColor.init(rgb: 0xdedfe0)
    static var superYellowColor = UIColor.init(rgb: 0xd7c97c)
    static var superLightBlueColor = UIColor.init(rgb: 0x4cb0cb)
    static var superLightPurpleColor = UIColor.init(rgb: 0xd9bafe)
    static var superLightSilverColor = UIColor.init(rgb: 0xa2b0be)
    static var lessYellowColor = UIColor.init(rgb: 0xd8c97c)
    static var noteDetailBackgroundColor = UIColor.init(rgb: 0x282b35)
    static var greenLightColor = UIColor.init(rgb: 0x77c2b2)
    //
    
    //dark colors:
    static var darkMatter = UIColor.init(rgb: 0x2a2d2f)
    
    
    //f4f7f9
    
    
    convenience init (red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    convenience init(rgb: Int) {
        self.init(
        red: (rgb >> 16) & 0xFF,
        green: (rgb >> 8) & 0xFF,
        blue: rgb & 0xFF
        )
    }
    
}
