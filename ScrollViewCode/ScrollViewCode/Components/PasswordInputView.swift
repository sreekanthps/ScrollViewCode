//
//  PasswordInputView.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 30/10/25.
//

import Foundation
import UIKit

class PasswordInputView: FormInputView {
    
    // Uses the same toggle function defined later in the main class
    let visibilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eye_on"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    
    
    init(title: String, placeholder: String) {
        super.init(title: title, placeholder: placeholder, isSecure: true)
        
        // Set up the eye icon button as the right view
        let containerView = UIView()
        visibilityButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(visibilityButton)

        NSLayoutConstraint.activate([
            visibilityButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            visibilityButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            visibilityButton.widthAnchor.constraint(equalToConstant: 24),
            visibilityButton.heightAnchor.constraint(equalToConstant: 24),
            containerView.widthAnchor.constraint(equalToConstant: 44),
            containerView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        self.textField.rightView = containerView
        self.textField.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
