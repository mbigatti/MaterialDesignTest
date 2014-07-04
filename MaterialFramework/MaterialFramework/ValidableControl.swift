//
//  ValidableControl.swift
//  MaterialFramework
//
//  Created by Massimiliano Bigatti on 03/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

import Foundation

protocol ValidableControl
{
    var valid : Bool { get }
    var errorMessage : String? { get set }
}