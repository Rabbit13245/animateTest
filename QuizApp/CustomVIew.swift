//
//  CustomVIew.swift
//  QuizApp
//
//  Created by Admin on 26.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesBegan")
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesEnded")
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesCancelled")
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var view = super.hitTest(point, with: event)
        print("CustomView hitTest: \(view)")
        
        return super.hitTest(point, with: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
