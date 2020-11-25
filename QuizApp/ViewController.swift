//
//  ViewController.swift
//  QuizApp
//
//  Created by Admin on 13.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIResponder {
    func responderChain() -> String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + " -> " + next.responderChain()
    }
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var editButton: UIButton!
    
    lazy var logoCell: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "camera")?.cgImage
        cell.scale = 0.2
        cell.scaleRange = 0.3
        cell.emissionRange = 2 * .pi
        cell.lifetime = 0.6
        cell.birthRate = 10
        cell.velocity = 50
        cell.velocityRange = 300
        cell.yAcceleration = 30
        cell.xAcceleration = 30
        cell.spin = -0.5
        cell.spinRange = 1.0
        return cell
    }()
    
    private var logoLayer = CAEmitterLayer()
    
    private var edit = false
    
    private var group = CAAnimationGroup()
    var animations = [CAKeyframeAnimation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(editButton.responderChain())
        
        editButton.layer.borderWidth = 2
        editButton.layer.borderWidth = 2
        editButton.layer.borderColor = UIColor.white.cgColor
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(showLogo(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapShowLogo(_:)))
        view.addGestureRecognizer(tap)
        //tap.cancelsTouchesInView = false
        //tap.delegate = self
        //view.addGestureRecognizer(longTap)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
    }
    
    @objc private func tapShowLogo(_ gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            print("began")
        case .ended:
            //print("Ended")
            logoShow(into: view, from: gestureRecognizer.location(in: view))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.logoRemove()
            }
        default:
            print("Default")
        }
    }
    
    @objc private func showLogo(_ gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            print("began")
            logoShow(into: view, from: gestureRecognizer.location(in: view))
        case .changed:
            print("changed")
            logoLayer.emitterPosition = gestureRecognizer.location(in: view)
        case .cancelled:
            print("Cancel")
        case .ended:
            print("Ended")
            logoRemove()
        default:
            print("Default")
        }
    }
    
    func logoShow(into view: UIView, from point: CGPoint) {
        logoLayer.emitterPosition = point
        logoLayer.emitterSize = view.bounds.size
        logoLayer.emitterShape = .point
        logoLayer.beginTime = CACurrentMediaTime()
        logoLayer.timeOffset = CFTimeInterval(arc4random_uniform(6) + 5)
        logoLayer.emitterCells = [logoCell]
        view.layer.addSublayer(logoLayer)
    }
    
    func logoRemove() {
        logoLayer.removeAllAnimations()
        logoLayer.removeFromSuperlayer()
    }
    
   
    @IBAction func buttonPress(_ sender: UIButton) {
        
        //print(sender.layer.presentation()?.value(forKey: "transform.rotation.z"))
        
        let rot = Double.pi / 180 * 18
        let animateTime = CFTimeInterval(0.3)
        let changePositon: CGFloat = 5
        
        if edit == false {
            animations.removeAll()
            
            let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.values = [0, -rot, 0, rot, 0]
            rotateAnimation.beginTime = animateTime / 5
            rotateAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
            rotateAnimation.isAdditive = true
            animations.append(rotateAnimation)

            let upDownAnimation = CAKeyframeAnimation(keyPath: "position.y")
            upDownAnimation.values = [0, -changePositon, 0, changePositon, 0]
            upDownAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
            upDownAnimation.isAdditive = true
            animations.append(upDownAnimation)

            let lefRightAnimation = CAKeyframeAnimation(keyPath: "position.x")
            lefRightAnimation.values = [0, -changePositon, 0, changePositon, 0]
            lefRightAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
            lefRightAnimation.isAdditive = true
            animations.append(lefRightAnimation)


            group.duration = animateTime
            group.animations = animations
            group.repeatCount = .infinity
            group.isRemovedOnCompletion = false

            editButton.layer.add(group, forKey: "totalGroup")
        } else {
            UIView.animate(withDuration: animateTime) {
                self.editButton.layer.removeAnimation(forKey: "totalGroup")
                self.editButton.transform = .identity
                self.editButton.layoutIfNeeded()
            }
        }
        edit.toggle()
    }
    
    deinit {
        print("first deinit")
    }
    
    let deleg = TransitioningDelegate()
    @IBAction func profileDidPress(_ sender: UIButton) {
        let secondVC = SecondViewController()
        secondVC.transitioningDelegate = deleg
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true, completion: nil)
    }
}

