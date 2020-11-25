//
//  TransitionDelegate.swift
//  QuizApp
//
//  Created by Admin on 24.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorTransitioning(type: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorTransitioning(type: .dismiss)
    }
}
