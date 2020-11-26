//
//  SecondVIew.swift
//  QuizApp
//
//  Created by Admin on 26.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SecondView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SecondVIew: touchesBegan")
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SecondVIew: touchesEnded")
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SecondVIew: touchesCancelled")
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var view = super.hitTest(point, with: event)
        print("SecondVIew hitTest: \(view)")
        
        return super.hitTest(point, with: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
