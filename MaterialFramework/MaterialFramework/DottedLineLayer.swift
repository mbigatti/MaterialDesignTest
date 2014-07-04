//
//  DottedLineLayer.swift
//  MaterialFramework
//
//  Created by Massimiliano Bigatti on 03/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

import QuartzCore

class DottedLineLayer: CAShapeLayer {

    init() {
        super.init()
        commonInit()
    }
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }
    init(layer: AnyObject!) {
        super.init(layer: layer)
        commonInit()
    }
    
    func commonInit()
    {
        backgroundColor = UIColor.clearColor().CGColor
        strokeStart = 0.0
        lineWidth = 1.0
        lineJoin = kCALineJoinMiter
        lineDashPattern = [2, 2]
    }

    func updateDottedLayerPath(h: CGFloat) {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: frame.size.height - h))
        path.addLineToPoint(CGPoint(x: frame.size.width, y: frame.size.height))
        
        self.path = path.CGPath
    }
    
}
