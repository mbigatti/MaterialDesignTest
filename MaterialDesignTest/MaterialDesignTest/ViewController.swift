//
//  ViewController.swift
//  MaterialDesignTest
//
//  Created by Massimiliano Bigatti on 01/07/14.
//  Copyright (c) 2014 Massimiliano Bigatti. All rights reserved.
//

import UIKit
import MaterialFramework

class ViewController: UIViewController {
                            
    @IBOutlet var projectTitleTextField: MaterialTextField
    @IBOutlet var descriptionTextView: MaterialTextView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        validateForm()
        
        descriptionTextView.placeholder = "Write here project notes"
        descriptionTextView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: -4)
        descriptionTextView.minHeight = 17
    }

    /*
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    */

    @IBAction func textFieldDidChange(textField: MaterialTextField) {
        validateForm()
    }
    
    func validateForm() {
        if projectTitleTextField.text.isEmpty {
            projectTitleTextField.errorMessage = "Project description is required"
        } else {
            projectTitleTextField.errorMessage = ""
        }
        
    }
}

