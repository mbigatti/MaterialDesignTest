//
//  MaterialTextField.swift
//  MaterialFramework
//
//  Created by Massimiliano Bigatti on 01/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class MaterialTextField: JVFloatLabeledTextField, ValidableControl {
    let underlineLayer = CALayer()
    let dottedLayer = DottedLineLayer()
    let errorLabel = UILabel()
    let errorImageView = UIImageView(image: UIImage(named: "icn_warning"))
    
    override func commonInit() {
        super.commonInit()
        
        self.layer.addSublayer(underlineLayer)
        self.layer.addSublayer(dottedLayer)
        
        errorMessageFont = UIFont.systemFontOfSize(10)
        errorColor = UIColor.redColor()
        errorLabel.hidden = true
        self.addSubview(errorLabel)
        
        errorImageView.hidden = true
        self.addSubview(errorImageView)
    }
    
    //
    // JVFloatLabeledTextView properties override
    //
    @IBInspectable override var floatingLabelTextColor : UIColor? {
    set (color) {
        super.floatingLabelTextColor = color
    }
    get {
        return super.floatingLabelTextColor
    }
    }
    
    @IBInspectable override var floatingLabelActiveTextColor : UIColor? {
    set (color) {
        super.floatingLabelActiveTextColor = color
    }
    get {
        return super.floatingLabelActiveTextColor
    }
    }    
    
    // redefined as Interface Builder does not support NSNumber yet
    @IBInspectable var floatingLabelYSpacing : CGFloat {
    set (newValue) {
        super.floatingLabelYPadding = NSNumber(float: newValue)
    }
    get {
        return super.floatingLabelYPadding.floatValue
    }
    }

    //
    //
    //
    @IBInspectable var underlineNormalColor: UIColor = UIColor.clearColor()
    @IBInspectable var underlineHighlightedColor: UIColor?
    @IBInspectable var underlineNormalHeight : CGFloat = 1
    @IBInspectable var underlineHighlightedHeight : CGFloat = 2
    
    //
    // error management
    //
    var valid : Bool {
    get {
        if let message = errorMessage {
            return message.isEmpty
        }
        return true
    }
    }
    
    var errorMessage : String? {
    didSet {
        errorLabel.text = errorMessage
        
        errorLabel.hidden = valid
        errorImageView.hidden = valid
        
        self.clipsToBounds = valid
        computeLineColor()
    }
    }
    
    @IBInspectable var errorMessageFont : UIFont {
        set (font) {
            errorLabel.font = font
        }
        get {
            return errorLabel.font
        }
    }
    
    @IBInspectable var errorColor : UIColor {
        set (color) {
            errorLabel.textColor = color
        }
        get {
            return errorLabel.textColor
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !valid {
            errorLabel.sizeToFit()
            
            errorLabel.frame = CGRect(
                x: 0,
                y: self.frame.size.height + errorLabel.frame.size.height / 2,
                width: min(errorLabel.frame.size.width, self.frame.size.width),
                height: errorLabel.frame.size.height)
            
            let width = errorImageView.image.size.width
            let height = errorImageView.image.size.height
            
            errorImageView.frame = CGRect(
                x: self.frame.size.width - width,
                y: errorLabel.frame.origin.y,
                width: width,
                height: height)
        }
    }
    
    override func layoutSublayersOfLayer(layer: CALayer!) {
        super.layoutSublayersOfLayer(layer);
        
        if (layer == self.layer) {
            computeLineColor()
            
            //
            // determine layer frame
            //
            let h = self.isFirstResponder() || !valid ? underlineHighlightedHeight : underlineNormalHeight
            let frame = CGRect(x: 0, y: self.frame.size.height - h, width: self.frame.size.width, height: h);
            
            if self.enabled {
                underlineLayer.opacity = 1
                underlineLayer.frame = frame
                dottedLayer.opacity = 0
            } else {
                underlineLayer.opacity = 0
                dottedLayer.opacity = 1
                dottedLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                
                dottedLayer.updateDottedLayerPath(h);
            }
            
        }
    }
    
    //
    // determine line color
    //
    func computeLineColor() {
        var lineColor = underlineNormalColor.CGColor
        
        if valid {
            if self.isFirstResponder() {
                if let color = underlineHighlightedColor {
                    lineColor = color.CGColor
                } else {
                    lineColor = self.tintColor.CGColor
                }
            }
        } else {
            lineColor = errorColor.CGColor
        }
        
        underlineLayer.backgroundColor = lineColor
        dottedLayer.strokeColor = lineColor
    }

}
