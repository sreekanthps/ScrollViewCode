//
//  labelFields.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 28/10/25.
//

import UIKit

class FullNameStackView: UIView {
    
    // MARK: - Properties
        
        private(set) var nameTextField: UITextField // Use private(set) for read-only access outside
        
        private let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 6
            stack.alignment = .fill
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        private let fullNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.textColor = UIColor(hexString: "4D4D4D")
            return label
        }()
        
        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.textColor = UIColor(hexString: "4D4D4D")
            label.numberOfLines = 0
            label.isHidden = true
            return label
        }()
    
    let textField: UITextField =  {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0 / UIScreen.main.scale
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        textField.isUserInteractionEnabled = false
        textField.leftViewMode = .always
        textField.textColor = UIColor(hexString: "OE0E0E")
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return  textField
    }()
        
        // MARK: - Initialization (Constructor)
        
    init(fullNameText: String, subtitleText: String? = nil, placeholderText: String, textfieldinfo: String? = nil) {
            
            // 1. Initialize the mutable text field property
            
            textField.placeholder = placeholderText
            
            // 2. Update textField property
            if let _textFieldInfo = textfieldinfo {
                textField.text = _textFieldInfo
            }
            self.nameTextField = textField
            
            super.init(frame: .zero) // Call designated initializer
            
            // 2. Set the text properties from constructor arguments
            self.fullNameLabel.text = fullNameText
            self.subtitleLabel.text = subtitleText
            // hide subtitle if empty or nil
            if let _subtitleText = subtitleText , !_subtitleText.isEmpty {
                self.subtitleLabel.isHidden = false
            }
        
            
            // 3. Set up the layout
            setupStackView()
        }
        
        required init?(coder: NSCoder) {
            // Fallback initialization for Interface Builder (though programmatic is assumed)
            fatalError("init(coder:) has not been implemented for programmatic view.")
        }
        
        // MARK: - Public Update Method
        
        /// Updates the text field's content programmatically.
        public func updateNameText(with newText: String) {
            self.nameTextField.text = newText
        }
        
        // MARK: - Setup
        
        private func setupStackView() {
            addSubview(stackView)
            
            // Add components to the stack view
            stackView.addArrangedSubview(fullNameLabel)
            stackView.addArrangedSubview(nameTextField)
            stackView.addArrangedSubview(subtitleLabel)
            
            // Pin the stack view to the custom view's edges
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        // MARK: - Subtitle helpers

        /// Set subtitle text. Pass `nil` or empty string to hide subtitle.
        public func setSubtitle(_ text: String?) {
            subtitleLabel.text = text
            if let subtitlText = text, !subtitlText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                subtitleLabel.isHidden = false
            } else {
                subtitleLabel.isHidden = true
            }
        }

        /// Show or hide the subtitle label without changing its text
        public func showSubtitle(_ show: Bool) {
            subtitleLabel.isHidden = !show
        }

        /// Returns whether subtitle is currently visible
        public var isSubtitleVisible: Bool { !subtitleLabel.isHidden }
}




