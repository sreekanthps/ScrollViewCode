//
//  UpdateCustomerDetails.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 28/10/25.
//

import Foundation
import UIKit

class UpdateCustomerDetails: UIViewController {
    
        // MARK: - Components
        
        // 1. Scroll View (The main container to handle scrolling)
        private let scrollView: UIScrollView = {
            let sv = UIScrollView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        
        // 2. Content View (A plain view inside the ScrollView to hold all form fields)
        private let contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            //view.backgroundColor = .yellow
            return view
        }()
        
        // 3. Form Elements (Using a StackView for organized vertical layout)
        private let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 10 // Spacing between major sections/fields
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    // MARK: - Setup and Layout
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        // 1. ScrollView Constraints (Pinned to Safe Area)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // 2. ContentView Constraints (Pinned to ScrollView's Content Layout Guide)
        // **CRITICAL for scrolling:** Pin all 4 edges to the scrollView's ContentLayoutGuide.
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            // **CRITICAL for vertical scrolling:** Set ContentView width equal to the View's width
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        // 3. StackView Constraints (Pinned inside the ContentView with padding)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // 4. Add Form Elements to the StackView
        addFormElements()
    }
    
    private func addFormElements() {
//        // Full Name Section
//        stackView.addArrangedSubview(createLabel(text: "Full Name"))
//        stackView.addArrangedSubview(createTextField(placeholder: "Your full name here"))
//        stackView.addArrangedSubview(createLabel(text: "As it appears on your NRIC or Passport"))
//        
//        // NRIC Section
//        stackView.addArrangedSubview(createLabel(text: "NRIC"))
//        stackView.addArrangedSubview(createTextField(placeholder: "E.G. S1233535A"))
//        
//        // Date of Birth Section
//        stackView.addArrangedSubview(createLabel(text: "Date of Birth"))
//        // Create custom view for Date of Birth field with calendar icon
//        let dobContainer = createTextField(placeholder: "Choose date")
//        dobContainer.rightViewMode = .always
//        dobContainer.rightView = UIImageView(image: UIImage(systemName: "calendar"))
//        stackView.addArrangedSubview(dobContainer)
//
//        // Address Fields (Horizontal Layouts)
//        
//        // Block & Street Row
//        stackView.addArrangedSubview(createLabel(text: "Block / Street")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Block here..."),
//            rightView: createTextField(placeholder: "Street name here...")
//        ))
//        
//        // Floor & Unit Row
//        stackView.addArrangedSubview(createLabel(text: "Floor / Unit")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Floor number here..."),
//            rightView: createTextField(placeholder: "Unit here...")
//        ))
//        
//        // Building Name
//        stackView.addArrangedSubview(createLabel(text: "Building Name"))
//        stackView.addArrangedSubview(createTextField(placeholder: "Building name here..."))
//        
//        // Country & Postal Code Row
//        stackView.addArrangedSubview(createLabel(text: "Country / Postal Code")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Country name here..."),
//            rightView: createTextField(placeholder: "Postal code here...", keyboardType: .numberPad)
//        ))
//        
//        // Block & Street Row
//        stackView.addArrangedSubview(createLabel(text: "Second Block / Street")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Block here..."),
//            rightView: createTextField(placeholder: "Street name here...")
//        ))
//        
//        // Floor & Unit Row
//        stackView.addArrangedSubview(createLabel(text: "Floor / Unit")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Floor number here..."),
//            rightView: createTextField(placeholder: "Unit here...")
//        ))
//        
//        // Building Name
//        stackView.addArrangedSubview(createLabel(text: "Building Name"))
//        stackView.addArrangedSubview(createTextField(placeholder: "Building name here..."))
//        
//        // Country & Postal Code Row
//        stackView.addArrangedSubview(createLabel(text: "Country / Postal Code")) // Combined label for the row
//        stackView.addArrangedSubview(createHorizontalStack(
//            leftView: createTextField(placeholder: "Country name here..."),
//            rightView: createTextField(placeholder: "Postal code here...", keyboardType: .numberPad)
//        ))
    }
    
}

