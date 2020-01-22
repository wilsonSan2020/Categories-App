//
//  CustomStackView.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/11/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit


class CustomStackView : UIStackView {

private var _bkgColor: UIColor?
override public var backgroundColor: UIColor? {
    get { return _bkgColor }
    set {
        _bkgColor = newValue
        setNeedsLayout()
    }
}

private lazy var backgroundLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    self.layer.insertSublayer(layer, at: 0)
    return layer
}()

override public func layoutSubviews() {
    super.layoutSubviews()
    backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
    backgroundLayer.fillColor = self.backgroundColor?.cgColor
}
}
