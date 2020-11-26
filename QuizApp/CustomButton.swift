//
//  CustomButton.swift
//  QuizApp
//
//  Created by Admin on 26.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("CustomButton hittest")
        
        return super.hitTest(point, with: event)
    }

}
