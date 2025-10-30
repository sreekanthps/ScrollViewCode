//
//  CreateAccount.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit


// MARK: - 1. MAIN VIEW CONTROLLER

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
    
    private let changeEmailButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setTitle("Change Email", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(UIColor(hexString: "003dA5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let changeMobileButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setTitle("Change Mobile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(UIColor(hexString: "003dA5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        let emailInput = FormInputView(title: "Email", placeholder: "abc@xyz.com")
        emailInput.titleLabel.addSubview(changeEmailButton)
        NSLayoutConstraint.activate([
            changeEmailButton.centerYAnchor.constraint(equalTo: emailInput.titleLabel.centerYAnchor),
            changeEmailButton.trailingAnchor.constraint(equalTo: emailInput.titleLabel.trailingAnchor, constant: 0)
        ])
        return emailInput
    }
    
    private func createMobileInputView() -> UIView {
        let mobileStack = FormInputView(title: "Mobile Number", placeholder: "9876 5431")
        let country = CountryPrefixView()
        mobileStack.textField.leftView = country
        mobileStack.textField.leftViewMode = .always
        mobileStack.titleLabel.addSubview(changeMobileButton)
        NSLayoutConstraint.activate([
            changeMobileButton.centerYAnchor.constraint(equalTo: mobileStack.titleLabel.centerYAnchor),
            changeMobileButton.trailingAnchor.constraint(equalTo: mobileStack.titleLabel.trailingAnchor, constant: 0)
        ])
        
        return mobileStack
    }

    private func createPasswordRulesView() -> UIView {
        // Use the reusable PasswordRulesView component
        let rulesView = PasswordRulesView()
        return rulesView
    }

    private func createDisclaimerView() -> UIView {
        let view = DisclaimerCheckboxView()

        // Example: handle link taps
        view.onLinkTapped = { id in
            if id == "agreement" {
                // present agreement
                print("Cardholders Agreement tapped")
            } else if id == "privacy" {
                print("Privacy Policy tapped")
            }
        }

        // Example: track checkbox state
        view.onCheckChanged = { checked in
            print("Disclaimer checked: \(checked)")
        }

        return view
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
        return LegalNoticeLabel()
        
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
