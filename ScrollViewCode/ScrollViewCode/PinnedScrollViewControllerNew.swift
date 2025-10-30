//
//  PinnedScrollViewControllerNew.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation

import UIKit

class PinnedScrollViewControllerNew: UIViewController {

    // MARK: - Components

    // 1. The Fixed Button (Footer)
    private let proceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Proceed", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        // Set a fixed height for the button
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 2. The Button's Container (For padding/safe area control)
    private let footerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 3. The Scroll View (The main content area)
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // 4. Content View (Crucial for defining scrollable size)
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    // 3. Form Elements (Using a StackView for organized vertical layout)
//    private let stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.spacing = 10 // Spacing between major sections/fields
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
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
    
    // 3. Form Elements (Using a StackView for organized vertical layout)
    private let horozantalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20 // Spacing between major sections/fields
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        addDummyScrollableContent() // Add content to test scrolling
    }
    
    // MARK: - Layout Setup

    private func setupLayout() {
        // 1. Add all components to the view hierarchy
        view.addSubview(scrollView)
        view.addSubview(footerContainer)
        footerContainer.addSubview(proceedButton)
        scrollView.addSubview(contentView)
        
        // 2. Pin the Footer/Button (Fixed Bottom)
        NSLayoutConstraint.activate([
            // Footer Container Pinned to screen edges (and bottom of the main view)
            footerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Button Pinned inside the container (above the safe area bottom inset)
            proceedButton.topAnchor.constraint(equalTo: footerContainer.topAnchor, constant: 12),
            proceedButton.leadingAnchor.constraint(equalTo: footerContainer.leadingAnchor, constant: 20),
            proceedButton.trailingAnchor.constraint(equalTo: footerContainer.trailingAnchor, constant: -20),
            proceedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
        
        // 3. Pin the ScrollView (Top to Safe Area, Bottom to Button Container)
        NSLayoutConstraint.activate([
            // PINS TOP TO SAFE AREA
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            // PINS BOTTOM TO BUTTON TOP
            scrollView.bottomAnchor.constraint(equalTo: footerContainer.topAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // 4. Define Scrollable Content (ContentView)
        NSLayoutConstraint.activate([
            // Pin ContentView edges to ScrollView's contentLayoutGuide
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            // CRITICAL: Set ContentView width equal to ScrollView width for vertical scrolling
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    // MARK: - Utility for Testing
    
    private func addDummyScrollableContent() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        stack.addArrangedSubview(accountInfoLabel)
        
        let nameFieldStack = FullNameStackView(fullNameText: "Sreekath", subtitleText: "No work", placeholderText: "Using GPT")
        nameFieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(nameFieldStack)
        
        let nw2 = FirstNameStackView(fullNameText: "NRIC", placeholderText: "G3205842L")
        nw2.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(nw2)
        
        let dob = FirstNameStackView(fullNameText: "Date of Birth", placeholderText: "Choose Date")
        nw2.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(dob)
        
        let block = FirstNameStackView(fullNameText: "Block", placeholderText: "Block Here")
        nw2.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(nw2)
        
        let street = FirstNameStackView(fullNameText: "street", placeholderText: "Street")
        nw2.translatesAutoresizingMaskIntoConstraints = false
       
        horozantalstackView.addArrangedSubview(block)
        horozantalstackView.addArrangedSubview(street)
        stack.addArrangedSubview(horozantalstackView)
        
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
        
        stack.addArrangedSubview(hstasck)
        
        let bldgName = FirstNameStackView(fullNameText: "Building Name", placeholderText: "Building Name here...")
        bldgName.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bldgName)
        
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
        
        
       // stack.addArrangedSubview(proceedButton)
        
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
}
