//
//  ViewController.swift
//  QuizApp
//
//  Created by Admin on 13.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    
    private var edit = false
    private var originCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.borderWidth = 2
        editButton.layer.borderWidth = 2
        editButton.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func buttonPress(_ sender: Any) {
        let oldPositionY = editButton.center.y;
        let oldPositionX = editButton.center.x;
        if edit == false {
//            var animations = [CABasicAnimation]()
//
//            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//            rotateAnimation.toValue = Double.pi / 180 * 18
//            rotateAnimation.autoreverses = true
//            rotateAnimation.repeatCount = .infinity
//
//            animations.append(rotateAnimation)
//
//            let rotateAnimation2 = CABasicAnimation(keyPath: "transform.rotation.z")
//            rotateAnimation2.toValue = -Double.pi / 180 * 18
//            rotateAnimation2.autoreverses = true
//            //rotateAnimation2.repeatCount = .infinity
//
//            animations.append(rotateAnimation2)
//
//            let downAnimation = CABasicAnimation(keyPath: "position.y")
//            downAnimation.toValue = oldPositionY + 5
//            downAnimation.autoreverses = true
//
//            //animations.append(downAnimation)
//
//            let upAnimation = CABasicAnimation(keyPath: "position.y")
//            upAnimation.toValue = oldPositionY - 5
//            upAnimation.autoreverses = true
//            //animations.append(upAnimation)
//
//            let leftAnimation = CABasicAnimation(keyPath: "position.x")
//            leftAnimation.toValue = oldPositionX - 5
//            leftAnimation.autoreverses = true
//            //animations.append(leftAnimation)
//
//            let rightAnimation = CABasicAnimation(keyPath: "position.y")
//            rightAnimation.toValue = oldPositionX + 5
//            rightAnimation.autoreverses = true
//            //animations.append(rightAnimation)
//
//            let group = CAAnimationGroup()
//            group.duration = 0.3
//            group.animations = animations
//            group.repeatCount = .infinity
            
            //editButton.layer.add(group, forKey: "rotate")
            originCenter = editButton.center
            
            UIView.animateKeyframes(withDuration: 0.3,
                                    delay: 0,
                                    options: [.allowUserInteraction, .repeat, .autoreverse],
                                    animations: {
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.0,
                                            relativeDuration: 0.16) {
                                            self.editButton.center = CGPoint(x: oldPositionX + 5, y: oldPositionY)
                                        }
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.16,
                                            relativeDuration: 0.16) {
                                            self.editButton.center = CGPoint(x: oldPositionX - 5, y: oldPositionY)
                                        }
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.32,
                                            relativeDuration: 0.16) {
                                            self.editButton.center = CGPoint(x: oldPositionX, y: oldPositionY + 5)
                                        }
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.48,
                                            relativeDuration: 0.16) {
                                            self.editButton.center = CGPoint(x: oldPositionX, y: oldPositionY - 5)
                                        }
                                    
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.64,
                                            relativeDuration: 0.16) {
                                            self.editButton.transform = CGAffineTransform(rotationAngle:  CGFloat(Double.pi / 180 * 18))
                                        }
                                        
                                        UIView.addKeyframe(
                                            withRelativeStartTime: 0.8,
                                            relativeDuration: 0.16) {
                                            self.editButton.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 180 * 18))
                                        }
                                    }, completion: nil)
            
            edit = true
        } else {
            editButton.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.3) {
                self.editButton.center = self.originCenter!
                self.editButton.transform = .identity
                //self.edit
            }
            edit = false
        }
    }
}

