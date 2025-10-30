//
//  labelFields.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 28/10/25.
//

import UIKit

class FullNameStackView: UIView {
    
    // MARK: - Properties
        
        // Expose the nameTextField publicly so its text can be accessed or modified
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
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            return label
        }()
        
        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            return label
        }()
        
        // MARK: - Initialization (Constructor)
        
        init(fullNameText: String, subtitleText: String, placeholderText: String) {
            
            // 1. Initialize the mutable text field property
            let tf = UITextField()
            tf.placeholder = placeholderText
            tf.layer.cornerRadius = 12
            tf.layer.borderWidth = 1.0 / UIScreen.main.scale
            tf.layer.borderColor = UIColor.systemGray4.cgColor
            tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
            tf.leftViewMode = .always
            tf.heightAnchor.constraint(equalToConstant: 48).isActive = true
            self.nameTextField = tf
            
            super.init(frame: .zero) // Call designated initializer
            
            // 2. Set the text properties from constructor arguments
            self.fullNameLabel.text = fullNameText
            self.subtitleLabel.text = subtitleText
            
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
}

class FirstNameStackView: UIView {
    
    // MARK: - Properties
        
        // Expose the nameTextField publicly so its text can be accessed or modified
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
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            return label
        }()
        
        
        // MARK: - Initialization (Constructor)
        
        init(fullNameText: String,placeholderText: String) {
            
            // 1. Initialize the mutable text field property
            let tf = UITextField()
            tf.placeholder = placeholderText
            tf.layer.cornerRadius = 12
            tf.layer.borderWidth = 1.0 / UIScreen.main.scale
            tf.layer.borderColor = UIColor.systemGray4.cgColor
            tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
            tf.leftViewMode = .always
            tf.heightAnchor.constraint(equalToConstant: 48).isActive = true
            self.nameTextField = tf
            super.init(frame: .zero) // Call designated initializer
            
            // 2. Set the text properties from constructor arguments
            self.fullNameLabel.text = fullNameText
            
            
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
            
            // Pin the stack view to the custom view's edges
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
}



// MARK: - Example Usage in a View Controller

class ExampleViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let nameFieldStack = FullNameStackView(fullNameText: "Sreekath", subtitleText: "No work", placeholderText: "Using GPT")
        nameFieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        let nw2 = FirstNameStackView(fullNameText: "NRIC", placeholderText: "G3205842L")
        nameFieldStack.translatesAutoresizingMaskIntoConstraints = false
       
        
        view.addSubview(nameFieldStack)
        view.addSubview(nw2)
        
        NSLayoutConstraint.activate([
            nameFieldStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameFieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameFieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
