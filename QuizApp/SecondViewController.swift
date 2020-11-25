//
//  SecondViewController.swift
//  QuizApp
//
//  Created by Admin on 24.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeDidPress), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func closeDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("second deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
                                        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}
