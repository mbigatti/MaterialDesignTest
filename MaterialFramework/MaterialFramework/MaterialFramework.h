//
//  MaterialFramework.h
//  MaterialFramework
//
//  Created by Massimiliano Bigatti on 03/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MaterialFramework.
FOUNDATION_EXPORT double MaterialFrameworkVersionNumber;

//! Project version string for MaterialFramework.
FOUNDATION_EXPORT const unsigned char MaterialFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MaterialFramework/PublicHeader.h>
#import <MaterialFramework/JVFloatLabeledTextField.h>
#import <MaterialFramework/JVFloatLabeledTextView.h>

//
// private interfaces for subclassing
//
@interface JVFloatLabeledTextField ()
- (void)commonInit;
@end

@interface JVFloatLabeledTextView ()
- (void)commonInit;
@end