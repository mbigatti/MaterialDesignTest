//
//  MaterialTextView.swift
//  MaterialFramework
//
//  ported from https://github.com/adam-siton/AUIAutoGrowingTextView
//
//  Created by Massimiliano Bigatti on 03/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class MaterialTextView: JVFloatLabeledTextView {
    var underlineLayer = CALayer()
    let dottedLayer = DottedLineLayer()
    let errorLabel = UILabel()
    let errorImageView = UIImageView(image: UIImage(named: "icn_warning"))
    
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
    
    @IBInspectable var minHeight : CGFloat = 0
    @IBInspectable var maxHeight : CGFloat = 0
    
    // private vars
    var heightConstraint : NSLayoutConstraint?
    
    override func commonInit() {
        super.commonInit()
        
        self.underlineLayer = CALayer()
        self.layer.addSublayer(underlineLayer)
        self.layer.addSublayer(dottedLayer)
        
        errorMessageFont = UIFont.systemFontOfSize(10)
        errorColor = UIColor.redColor()
        errorLabel.hidden = true
        self.addSubview(errorLabel)
        
        errorImageView.hidden = true
        self.addSubview(errorImageView)
        
        // find height constraint
        for constraint in self.constraints() as NSLayoutConstraint[] {
            if constraint.firstAttribute == .Height {
                heightConstraint = constraint
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayers()

        if heightConstraint {
            adjustHeight()
        }
    }
    
    func underlineHeight() -> CGFloat {
        return self.isFirstResponder() || !valid ? underlineHighlightedHeight : underlineNormalHeight
    }
    
    override func layoutSublayersOfLayer(layer: CALayer!) {
        super.layoutSublayersOfLayer(layer);
        
        if (layer == self.layer) {
            computeLineColor()
            updateLayers()
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
    
    //
    // determine layer frame
    //
    func updateLayers() {
        let h = underlineHeight()
        let y = self.frame.size.height - h
        let frame = CGRect(x: 0, y: y, width: self.frame.size.width, height: h);
        
        if self.editable {
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
    
    func adjustHeight() {
        var intrinsicSize = self.intrinsicContentSize()
        
        if (minHeight != 0) {
            intrinsicSize.height = max(intrinsicSize.height, minHeight)
        }
        if (maxHeight != 0) {
            intrinsicSize.height = min(intrinsicSize.height, maxHeight)
        }
        
        heightConstraint!.constant = intrinsicSize.height
        
        // Center vertically
        // We're  supposed to have a maximum height contstarint in code for the text view which will makes the intrinsicSide eventually higher then the height of the text view - if we had enough text.
        // This code only center vertically the text view while the context size is smaller/equal to the text view frame.
        if (self.intrinsicContentSize().height <= self.bounds.size.height) {
            var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale)/2.0
            topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect )
            self.contentOffset = CGPoint(x: 0, y: -topCorrect)
        }
    }
    
    override func intrinsicContentSize() -> CGSize
    {
        var intrinsicContentSize = self.contentSize;
        
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 7.0 {
            intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0;
            intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0;
        }
        
        return intrinsicContentSize;
    }
}