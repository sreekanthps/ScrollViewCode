//
//  UpdateUserDetails.swift
//  ScrollViewPage
//
//  Created by sreekanth Pulicherla on 27/10/25.
//

import Foundation
import UIKit

class UpdateUserDetails: UIViewController {
    
    // MARK: - Components
    
        
        
        // 1. Scroll View (The main container to handle scrolling)
        private let scrollView: UIScrollView = {
            let sv = UIScrollView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            // Ensure the content size adjusts dynamically
            //sv.alwaysScrollsVertical = true
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
            stack.spacing = 15 // Spacing between major sections/fields
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
    
        // 3. Form Elements (Using a StackView for organized vertical layout)
        private let horozantalstackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 20 // Spacing between major sections/fields
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
    let accountInfoLabel: UILabel = {
        let label = UILabel()
        
        // Set the text content
        label.text = "Account info"
        
        // Set the font to be large and bold, matching the image's style
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        
        // Disable autoresizing masks to use Auto Layout constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let proceedButton: UIButton = {
            let button = UIButton(type: .system)
            
            // 1. Text and Appearance
            button.setTitle("Proceed", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
            
            // 2. Background and Text Color
            button.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.8, alpha: 1.0) // Deep Blue
            button.setTitleColor(.white, for: .normal)
            
            // 3. Size and Corner Radius
            button.layer.cornerRadius = 12 // Highly rounded corners (half of the desired height)
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true // Fixed height
            
            // 4. Add Action (Optional but recommended for completeness)
            button.addTarget(self, action: #selector(handleProceedTap), for: .touchUpInside)

            return button
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
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            ])
            
            // 4. Add Form Elements to the StackView
            addFormElements()
        }
        
        private func createTextField(placeholder: String, keyboardType: UIKeyboardType = .default) -> UITextField {
            let tf = UITextField()
            tf.placeholder = placeholder
            tf.borderStyle = .roundedRect
            tf.keyboardType = keyboardType
            // Set a minimum height constraint to ensure visibility
            tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
            return tf
        }
        
        private func createLabel(text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return label
        }

        private func addFormElements() {
            
            
            stackView.addArrangedSubview(accountInfoLabel)
            
            let nameFieldStack = FullNameStackView(fullNameText: "Sreekath", subtitleText: "No work", placeholderText: "Using GPT")
            nameFieldStack.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(nameFieldStack)
            
            let nw2 = FirstNameStackView(fullNameText: "NRIC", placeholderText: "G3205842L")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(nw2)
            
            let dob = FirstNameStackView(fullNameText: "Date of Birth", placeholderText: "Choose Date")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(dob)
            
            let block = FirstNameStackView(fullNameText: "Block", placeholderText: "Block Here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(nw2)
            
            let street = FirstNameStackView(fullNameText: "street", placeholderText: "Street")
            nw2.translatesAutoresizingMaskIntoConstraints = false
           
            horozantalstackView.addArrangedSubview(block)
            horozantalstackView.addArrangedSubview(street)
            stackView.addArrangedSubview(horozantalstackView)
            
            // 3. Form Elements (Using a StackView for organized vertical layout)
            let hstasck = UIStackView()
            
            hstasck.axis = .horizontal
            hstasck.distribution = .fillEqually
            hstasck.spacing = 20 // Spacing between major sections/fields
            hstasck.translatesAutoresizingMaskIntoConstraints = false
            
            
            let floor = FirstNameStackView(fullNameText: "Floor", placeholderText: "Block Here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            
            
            let unit = FirstNameStackView(fullNameText: "street", placeholderText: "Street")
            nw2.translatesAutoresizingMaskIntoConstraints = false
           
            hstasck.addArrangedSubview(floor)
            hstasck.addArrangedSubview(unit)
            
            stackView.addArrangedSubview(hstasck)
            
            let bldgName = FirstNameStackView(fullNameText: "Building Name", placeholderText: "Building Name here...")
            bldgName.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bldgName)
            
            let hstasck2 = UIStackView()
            
            hstasck2.axis = .horizontal
            hstasck2.distribution = .fillEqually
            hstasck2.spacing = 20 // Spacing between major sections/fields
            hstasck2.translatesAutoresizingMaskIntoConstraints = false
            
            
            let country = FirstNameStackView(fullNameText: "Country", placeholderText: "Country Name here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            
            
            let pocode = FirstNameStackView(fullNameText: "Postal Code", placeholderText: "Country Name here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
           
            hstasck2.addArrangedSubview(country)
            hstasck2.addArrangedSubview(pocode)
            
            //stackView.addArrangedSubview(hstasck2)
            
            
            //stackView.addArrangedSubview(spacer)
            
            let nameFieldStack1 = FullNameStackView(fullNameText: "Sreekath", subtitleText: "No work", placeholderText: "Using GPT")
            nameFieldStack1.translatesAutoresizingMaskIntoConstraints = false
            
            //stackView.addArrangedSubview(nameFieldStack1)
            
            let nameFieldStack2 = FullNameStackView(fullNameText: "Sreekath", subtitleText: "No work", placeholderText: "Using GPT")
            nameFieldStack2.translatesAutoresizingMaskIntoConstraints = false
            
            //stackView.addArrangedSubview(nameFieldStack2)
            
            
            stackView.addArrangedSubview(proceedButton)
            
//            // Full Name Section
//            stackView.addArrangedSubview(createLabel(text: "Full Name"))
//            stackView.addArrangedSubview(createTextField(placeholder: "Your full name here"))
//            stackView.addArrangedSubview(createLabel(text: "As it appears on your NRIC or Passport"))
//            
//            // NRIC Section
//            stackView.addArrangedSubview(createLabel(text: "NRIC"))
//            stackView.addArrangedSubview(createTextField(placeholder: "E.G. S1233535A"))
//            
//            // Date of Birth Section
//            stackView.addArrangedSubview(createLabel(text: "Date of Birth"))
//            // Create custom view for Date of Birth field with calendar icon
//            let dobContainer = createTextField(placeholder: "Choose date")
//            dobContainer.rightViewMode = .always
//            dobContainer.rightView = UIImageView(image: UIImage(systemName: "calendar"))
//            stackView.addArrangedSubview(dobContainer)
//
//            // Address Fields (Horizontal Layouts)
//            
//            // Block & Street Row
//            stackView.addArrangedSubview(createLabel(text: "Block / Street")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Block here..."),
//                rightView: createTextField(placeholder: "Street name here...")
//            ))
//            
//            // Floor & Unit Row
//            stackView.addArrangedSubview(createLabel(text: "Floor / Unit")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Floor number here..."),
//                rightView: createTextField(placeholder: "Unit here...")
//            ))
//            
//            // Building Name
//            stackView.addArrangedSubview(createLabel(text: "Building Name"))
//            stackView.addArrangedSubview(createTextField(placeholder: "Building name here..."))
//            
//            // Country & Postal Code Row
//            stackView.addArrangedSubview(createLabel(text: "Country / Postal Code")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Country name here..."),
//                rightView: createTextField(placeholder: "Postal code here...", keyboardType: .numberPad)
//            ))
//            
//            // Block & Street Row
//            stackView.addArrangedSubview(createLabel(text: "Second Block / Street")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Block here..."),
//                rightView: createTextField(placeholder: "Street name here...")
//            ))
//            
//            // Floor & Unit Row
//            stackView.addArrangedSubview(createLabel(text: "Floor / Unit")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Floor number here..."),
//                rightView: createTextField(placeholder: "Unit here...")
//            ))
//            
//            // Building Name
//            stackView.addArrangedSubview(createLabel(text: "Building Name"))
//            stackView.addArrangedSubview(createTextField(placeholder: "Building name here..."))
//            
//            // Country & Postal Code Row
//            stackView.addArrangedSubview(createLabel(text: "Country / Postal Code")) // Combined label for the row
//            stackView.addArrangedSubview(createHorizontalStack(
//                leftView: createTextField(placeholder: "Country name here..."),
//                rightView: createTextField(placeholder: "Postal code here...", keyboardType: .numberPad)
//            ))
        }
        
        // Helper function for 50/50 horizontal split fields
        private func createHorizontalStack(leftView: UIView, rightView: UIView) -> UIStackView {
            let stack = UIStackView(arrangedSubviews: [leftView, rightView])
            stack.axis = .horizontal
            stack.spacing = 16
            stack.distribution = .fillEqually
            return stack
        }
        
        @objc func handleProceedTap() {
            print("Proceed button was tapped!")
            // Add navigation or action logic here
        }
        
}

