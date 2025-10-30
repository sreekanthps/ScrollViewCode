//
//  FloatingButton.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 28/10/25.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private var dateField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Account"
        
        setupScrollView()
        setupStackView()
        addFormFields()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            // critical for vertical scroll to behave properly
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        contentView.addSubview(stackView)
        
        let minHeightConstraint = stackView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor
        )
        minHeightConstraint.priority = .defaultLow
        minHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func addFormFields() {
        // --- Form Fields ---
        stackView.addArrangedSubview(createLabel("Full Name"))
        stackView.addArrangedSubview(createTextField("Your full name here..."))
        
        stackView.addArrangedSubview(createLabel("As it appears on your NRIC or Passport"))
        
        stackView.addArrangedSubview(createLabel("NRIC"))
        stackView.addArrangedSubview(createTextField("E.G. S1233535A"))
        
        stackView.addArrangedSubview(createLabel("Date of Birth"))
        let dateTextField = createDateField()
        stackView.addArrangedSubview(dateTextField)
        self.dateField = dateTextField
        
        let addressStack1 = createHorizontalStack([
            createTextField("Block here..."),
            createTextField("Street name here...")
        ])
        let addressStack2 = createHorizontalStack([
            createTextField("Floor number here..."),
            createTextField("Unit here...")
        ])
        let addressStack3 = createTextField("Building name here...")
        let addressStack4 = createHorizontalStack([
            createTextField("Country name here..."),
            createTextField("Postal code here...")
        ])
        
//        stackView.addArrangedSubview(createLabel("Address"))
//        stackView.addArrangedSubview(addressStack1)
//        stackView.addArrangedSubview(addressStack2)
//        stackView.addArrangedSubview(addressStack3)
//        stackView.addArrangedSubview(addressStack4)
//        
//        let addressStack5 = createHorizontalStack([
//            createTextField("Block here..."),
//            createTextField("Street name here...")
//        ])
//        
//        let addressStack6 = createHorizontalStack([
//            createTextField("Block here..."),
//            createTextField("Street name here...")
//        ])
//        
//        let addressStack7 = createHorizontalStack([
//            createTextField("Block here..."),
//            createTextField("Street name here...")
//        ])
//        stackView.addArrangedSubview(addressStack5)
//        stackView.addArrangedSubview(addressStack6)
//        stackView.addArrangedSubview(addressStack7)

        
        // --- Spacer (important for bottom alignment) ---
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(spacer)
        
        // --- Bottom Submit Button ---
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        stackView.addArrangedSubview(submitButton)
    }
    
    // MARK: - UI Helpers
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }
    
    private func createTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return textField
    }
    
    private func createDateField() -> UITextField {
        let textField = createTextField("Choose date")
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(dateIconTapped), for: .touchUpInside)
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }
    
    private func createHorizontalStack(_ views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }
    
    // MARK: - Actions
    
    @objc private func dateIconTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        let alert = UIAlertController(title: "Select Date of Birth",
                                      message: "\n\n\n\n\n\n\n\n\n",
                                      preferredStyle: .actionSheet)
        alert.isModalInPresentation = true
        
        datePicker.frame = CGRect(x: 10, y: 30, width: alert.view.bounds.width - 40, height: 200)
        alert.view.addSubview(datePicker)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] _ in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self?.dateField?.text = formatter.string(from: datePicker.date)
        }))
        
        present(alert, animated: true)
    }
    
    @objc private func submitTapped() {
        print("✅ Submit button tapped!")
        // Add your form submission logic here
    }
}
