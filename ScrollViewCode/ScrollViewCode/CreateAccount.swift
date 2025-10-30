//
//  CreateAccount.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit

// MARK: - 1. HELPER VIEWS DEFINITIONS

// --- Base Class: FormInputView ---
// Encapsulates a Title Label and a Styled Text Field.
class FormInputView: UIView {
    
    // Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
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

// --- Specialized Class: PasswordInputView ---
// Inherits from FormInputView and adds the eye icon for security toggle.
class PasswordInputView: FormInputView {
    
    // Uses the same toggle function defined later in the main class
    let visibilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eye_on"), for: .normal)
        button.tintColor = .systemGray
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return button
    }()
    
    
    
    init(title: String, placeholder: String) {
        super.init(title: title, placeholder: placeholder, isSecure: true)
        
        // Set up the eye icon button as the right view
        let containerView = UIView()
        containerView.addSubview(visibilityButton)

        NSLayoutConstraint.activate([
            visibilityButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            visibilityButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50), // inner margin
            visibilityButton.widthAnchor.constraint(equalToConstant: 40),
            visibilityButton.heightAnchor.constraint(equalToConstant: 40),
            containerView.widthAnchor.constraint(equalToConstant: 40), // outer margin to textfield border
            containerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.textField.rightView = containerView
        self.textField.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - 2. MAIN VIEW CONTROLLER

class CreateAccountViewController: UIViewController {

    // MARK: - Core UI Components
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let formStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        addContentToStack()
    }
    
    // MARK: - Layout Setup

    private func setupLayout() {
        // Add views to the hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(formStackView)
        
        // Pin the ScrollView to all four sides of the Safe Area
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // Define Scrollable Content (ContentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
        
        // Pin Form Stack to ContentView
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            formStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            formStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            formStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    // MARK: - Content Population
    
    private func addContentToStack() {
//        // 1. Back Button and Title
//        let backButton = createBackButton()
//        formStackView.addArrangedSubview(backButton)
        
        let titleLabel = createTitleLabel()
        formStackView.addArrangedSubview(titleLabel)
        formStackView.setCustomSpacing(25, after: titleLabel)

        // 2. Email Input
        formStackView.addArrangedSubview(createEmailInputView())
        
        // 3. Mobile Input
        formStackView.addArrangedSubview(createMobileInputView())

        // 4. Password Inputs
        let passwordInput = PasswordInputView(title: "Password", placeholder: "Pass@123")
        passwordInput.visibilityButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        formStackView.addArrangedSubview(passwordInput)
        
        let confirmPasswordInput = PasswordInputView(title: "Confirm Password", placeholder: "********")
        confirmPasswordInput.visibilityButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        formStackView.addArrangedSubview(confirmPasswordInput)
        
        formStackView.setCustomSpacing(25, after: formStackView.arrangedSubviews.last!)

        // 5. Password Rules
        formStackView.addArrangedSubview(createPasswordRulesView())
        formStackView.setCustomSpacing(30, after: formStackView.arrangedSubviews.last!)

        // 6. Disclaimer/Checkbox
        formStackView.addArrangedSubview(createDisclaimerView())
        formStackView.setCustomSpacing(30, after: formStackView.arrangedSubviews.last!)

        // 7. Register Button
        formStackView.addArrangedSubview(createRegisterButton())
        
        // 8. Final Legal Text
        formStackView.addArrangedSubview(createFinalLegalText())
    }
    
    // MARK: - Helper View Factory Methods (for clarity)

    private func createBackButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .label
        button.contentHorizontalAlignment = .left
        return button
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Create account"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }

    private func createEmailInputView() -> UIView {
        let emailInput = FormInputView(title: "Email", placeholder: "ragvana@gmail.com")
        let changeButton = UIButton(type: .system)
        changeButton.setTitle("Change Email", for: .normal)
        changeButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        changeButton.setTitleColor(UIColor(hexString: "003dA5"), for: .normal)
        
        emailInput.titleLabel.addSubview(changeButton)
        
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeButton.centerYAnchor.constraint(equalTo: emailInput.titleLabel.centerYAnchor),
            changeButton.trailingAnchor.constraint(equalTo: emailInput.titleLabel.trailingAnchor, constant: 0)
        ])
        return emailInput
    }
    
    private func createMobileInputView() -> UIView {
        let mobileStack = FormInputView(title: "Mobile Number", placeholder: "9876 5431")
        
        // Simplified flag and code UI integration
        let prefixStack = UIStackView()
        prefixStack.spacing = 4
        prefixStack.alignment = .center
        
        let flag = UILabel()
        flag.text = " 🇸🇬 +65 "
        flag.textColor = UIColor(hexString: "8D8D8D")
        flag.font = .systemFont(ofSize: 14, weight: .medium)
        
        let arrow = UIImageView(image: UIImage(systemName: "chevron.down"))
        arrow.contentMode = .scaleAspectFit
        arrow.widthAnchor.constraint(equalToConstant: 12).isActive = true

        prefixStack.addArrangedSubview(flag)
        prefixStack.addArrangedSubview(arrow)
        prefixStack.isLayoutMarginsRelativeArrangement = true
        prefixStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)

        mobileStack.textField.leftView = prefixStack
        mobileStack.textField.leftViewMode = .always
        
        // Change Mobile Button
        let changeMobileButton = UIButton(type: .system)
        changeMobileButton.setTitle("Change Mobile", for: .normal)
        changeMobileButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        changeMobileButton.setTitleColor(UIColor(hexString: "003dA5"), for: .normal)
        mobileStack.titleLabel.addSubview(changeMobileButton)
        
        changeMobileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeMobileButton.centerYAnchor.constraint(equalTo: mobileStack.titleLabel.centerYAnchor),
            changeMobileButton.trailingAnchor.constraint(equalTo: mobileStack.titleLabel.trailingAnchor, constant: 0)
        ])
        
        return mobileStack
    }

    private func createPasswordRulesView() -> UIStackView {
        let rulesStack = UIStackView()
        rulesStack.axis = .vertical
        rulesStack.spacing = 8
        rulesStack.alignment = .leading
        
        let title = UILabel()
        title.text = "Your password must contain:"
        title.font = .systemFont(ofSize: 15, weight: .semibold)
        rulesStack.addArrangedSubview(title)
        
        let rules = [
            "At least 8 alphanumeric characters",
            "One uppercase character",
            "One lowercase character",
            "One number",
            "Confirm new password matches"
        ]
        
        for rule in rules {
            let itemStack = UIStackView()
            itemStack.spacing = 8
            
            let checkmark = UIImageView(image: UIImage(named: "check"))
            checkmark.tintColor = .systemBlue
            checkmark.widthAnchor.constraint(equalToConstant: 16).isActive = true
            checkmark.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            let label = UILabel()
            label.text = rule
            label.font = .systemFont(ofSize: 14)
            
            itemStack.addArrangedSubview(checkmark)
            itemStack.addArrangedSubview(label)
            rulesStack.addArrangedSubview(itemStack)
        }
        
        return rulesStack
    }

    private func createDisclaimerView() -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        let checkboxContainer = UIStackView()
        checkboxContainer.spacing = 8
        
        let checkbox = UIImageView(image: UIImage(systemName: "checkmark.square.fill"))
        checkbox.tintColor = .systemBlue
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.tintColor = .systemBlue

        // Set size (if you’re not using Auto Layout)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 14)
        
        // Attributed text for links
        let fullText = "I confirm that I have read, understood and accept NETS for Cardholders Agreement and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "003dA5"),
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        
        let paragraphStyle = NSMutableParagraphStyle()
                
                // 3. Set the desired line spacing value
                paragraphStyle.lineSpacing = 5
        // Apply link styling to specific words
        
        attributedString.addAttributes(linkAttributes, range: (fullText as NSString).range(of: "Cardholders Agreement"))
        attributedString.addAttributes(linkAttributes, range: (fullText as NSString).range(of: "Privacy Policy"))
        attributedString.addAttribute(
                    .paragraphStyle,
                    value: paragraphStyle,
                    range: NSRange(location: 0, length: attributedString.length)
                )
        
        textLabel.attributedText = attributedString
        
        checkboxContainer.addArrangedSubview(button)
        checkboxContainer.addArrangedSubview(textLabel)
        stack.addArrangedSubview(checkboxContainer)
        
        return stack
    }
    
    private func createRegisterButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "CACACA") //CACACA //003dA5
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .clear
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleRegisterButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func handleRegisterButtonTapped() {
        let popupVC = CountrySelectorPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen // Essential for modal transparency
        popupVC.modalTransitionStyle = .crossDissolve //
        self.present(popupVC, animated: true, completion: nil)
    }
    
    private func createFinalLegalText() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        //label.textColor = UIColor(hexString: "666666")
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "666666"),
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        
        // 1. Create a mutable attributed string with the text
        let attributedString = NSMutableAttributedString(string: "The collection, use, disclosure and sharing of this information, which to the best of my knowledge and belief is true and accurate for purposes reasonably required to process my submission which are set out in NETS' Data protection policy.", attributes: linkAttributes)
                
                // 2. Create the paragraph style object
                let paragraphStyle = NSMutableParagraphStyle()
                
                // 3. Set the desired line spacing value
                paragraphStyle.lineSpacing = 4
        
        attributedString.addAttribute(
                    .paragraphStyle,
                    value: paragraphStyle,
                    range: NSRange(location: 0, length: attributedString.length)
                )
        label.attributedText = attributedString
       
        return label
        
        
    }

    // MARK: - Actions
    
    @objc private func toggleVisibility(_ sender: UIButton) {
        // Find the parent's sibling text field
        guard let container = sender.superview?.superview?.superview,
              let passwordInput = container as? PasswordInputView
        else { return }
        
        let textField = passwordInput.textField
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
