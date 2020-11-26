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

    private let rot = Double.pi / 180 * 18
    private let pos: CGFloat = 5
    
    private lazy var editButton: AnimateButton = {
        let button = AnimateButton(animateTime: 0.3, rotationAngle: rot, changePosition: pos)
        button.setTitle("Edit", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(buttonDidPres), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func buttonDidPres() {
        if !edit {
            editButton.startAnimate()
        } else {
            editButton.stopAnimate()
        }
        edit.toggle()
    }
    
    override func loadView() {
        self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(showLogo(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapShowLogo(_:)))
        view.addGestureRecognizer(tap)
        //tap.cancelsTouchesInView = false
        //tap.delegate = self
        //view.addGestureRecognizer(longTap)
        
        view.addSubview(editButton)
        
        let secondView = SecondView()
        secondView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondView)
        
        NSLayoutConstraint.activate([
                                        editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        editButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
            secondView.widthAnchor.constraint(equalToConstant: 50),
            secondView.heightAnchor.constraint(equalToConstant: 50),
            secondView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
    }
    
    @objc private func tapShowLogo(_ gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
        case .ended:
            print("GestureMethod")
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

