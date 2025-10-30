//
//  FormInputView.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 30/10/25.
//

import Foundation
import UIKit


class FormInputView: UIView {
    
    // Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hexString: "4D4D4D")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 12.0
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.systemGray4.cgColor
        tf.backgroundColor = .white
        
        // Add left padding
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        tf.leftViewMode = .always
        tf.heightAnchor.constraint(equalToConstant: 48).isActive = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    init(title: String, placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
