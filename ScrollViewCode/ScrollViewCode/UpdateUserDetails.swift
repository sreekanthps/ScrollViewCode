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
             return sv
        }()
        
        // 2. Content View (A plain view inside the ScrollView to hold all form fields)
        private let contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
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

    // Reference to inline proceed button (inside the stack)
    private var inlineProceedButton: UIButton?

    // External bottom-anchored proceed button (shown only when content fits)
    private lazy var bottomProceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Proceed", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.8, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(handleProceedTap), for: .touchUpInside)
        button.isHidden = true
        return button
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
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
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
            // Add external bottom proceed button so it can be pinned to safe area when needed
            view.addSubview(bottomProceedButton)
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

            // Bottom proceed button constraints (anchored to safe area)
            NSLayoutConstraint.activate([
                bottomProceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                bottomProceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                bottomProceedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])
            
            // 4. Add Form Elements to the StackView
            addFormElements()
        }
        
        private func addFormElements() {
            
            
            stackView.addArrangedSubview(accountInfoLabel)
            
            stackView.setCustomSpacing(20, after: accountInfoLabel)
            
            let nameFieldStack = FullNameStackView(fullNameText: "Full name", subtitleText: "As it appears on your NRIC or Passport", placeholderText: "Full Name")
            nameFieldStack.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(nameFieldStack)
            
            // NRIC
            let nw2 = FullNameStackView(fullNameText: "NRIC", placeholderText: "G3205842L")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(nw2)
            
            // Date of Birth
            let dob = FullNameStackView(fullNameText: "Date of Birth", placeholderText: "Choose Date", textfieldinfo: "02/02/1989")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(dob)
            
            // Block
            let block = FullNameStackView(fullNameText: "Block", placeholderText: "Block Here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(nw2)
            
            // Street
            let street = FullNameStackView(fullNameText: "street", placeholderText: "Street")
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
            
            // FLoor
            let floor = FullNameStackView(fullNameText: "Floor", placeholderText: "Block Here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            
            // Unit
            
            let unit = FullNameStackView(fullNameText: "street", placeholderText: "Street")
            nw2.translatesAutoresizingMaskIntoConstraints = false
           
            hstasck.addArrangedSubview(floor)
            hstasck.addArrangedSubview(unit)
            
            stackView.addArrangedSubview(hstasck)
            
            // Building Name here
            let bldgName = FullNameStackView(fullNameText: "Building Name", placeholderText: "Building Name here...")
            bldgName.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(bldgName)
            
            let hstasck2 = UIStackView()
            
            hstasck2.axis = .horizontal
            hstasck2.distribution = .fillEqually
            hstasck2.spacing = 20 // Spacing between major sections/fields
            hstasck2.translatesAutoresizingMaskIntoConstraints = false
            
            // Country
            let country = FullNameStackView(fullNameText: "Country", placeholderText: "Country Name here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
            
            // Country
            let pocode = FullNameStackView(fullNameText: "Postal Code", placeholderText: "Country Name here")
            nw2.translatesAutoresizingMaskIntoConstraints = false
           
            hstasck2.addArrangedSubview(country)
            hstasck2.addArrangedSubview(pocode)
            
            
            stackView.addArrangedSubview(proceedButton)
            // Keep reference to the inline proceed button so we can toggle visibility
            inlineProceedButton = proceedButton
        }

    // MARK: - Layout adjustments

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateProceedButtonVisibility()
    }

    private func updateProceedButtonVisibility() {
        // available height inside the safe area
        let availableHeight = view.safeAreaLayoutGuide.layoutFrame.height

        // compute total height of stack content excluding the inline proceed button
        func contentHeightExcludingInline() -> CGFloat {
            contentView.layoutIfNeeded()

            var stackWidth = stackView.bounds.width
            if stackWidth <= 0 {
                stackWidth = max(0, contentView.bounds.width - 48)
            }

            let arranged = stackView.arrangedSubviews.filter { $0 !== inlineProceedButton }
            var total: CGFloat = 0

            for viewItem in arranged {
                let targetSize = CGSize(width: stackWidth, height: UIView.layoutFittingCompressedSize.height)
                let size = viewItem.systemLayoutSizeFitting(targetSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .fittingSizeLevel)
                total += size.height
            }

            if arranged.count > 1 {
                total += CGFloat(arranged.count - 1) * stackView.spacing
            }

            total += 24 + 24 // top & bottom padding applied to stack
            return total
        }

        let formContentHeight = contentHeightExcludingInline()
        let bottomButtonTotal: CGFloat = 44 + 16

        let shouldUseBottom = (formContentHeight + bottomButtonTotal) <= availableHeight

        inlineProceedButton?.isHidden = shouldUseBottom
        bottomProceedButton.isHidden = !shouldUseBottom
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

