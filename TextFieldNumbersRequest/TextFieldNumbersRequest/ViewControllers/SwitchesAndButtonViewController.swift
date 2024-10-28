//
//  SwitchesAndButtonViewController.swift
//  TextFieldNumbersRequest
//
//  Created by Алсу Хайруллина on 28.10.2024.
//

import UIKit

class SwitchesAndButtonViewController: UIViewController {
    
    //MARK: Views
    private lazy var switch1 = UISwitch()
    private lazy var switch2 = UISwitch()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switch1, switch2, button])
        stack.spacing = 10
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}

//MARK: - UI Setup
private extension SwitchesAndButtonViewController {
    func setupViews() {
        
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 60),
            vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

