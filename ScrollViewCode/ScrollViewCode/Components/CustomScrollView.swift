//
//  CustomScrollView.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit

class CustomScrollView: UIScrollView {
    
    
    // 1. Content View (Crucial for defining scrollable size)
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 2. Form Elements (Using a StackView for organized vertical layout)
     let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15 // Spacing between major sections/fields
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init () {
        super.init(frame: .zero)
        setupScrollView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
     func setupScrollView() {
        // Define Scrollable Content (ContentView)
        
        self.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor),
        ])
        
        // Pin Form Stack to ContentView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])

        // Provide a flexible minimum height so the stackView will not collapse to zero when
        // the scroll view or its content undergoes layout changes. Keep priority low so it
        // doesn't fight other stronger constraints.
        let minHeight = stackView.heightAnchor.constraint(greaterThanOrEqualTo: self.frameLayoutGuide.heightAnchor)
        minHeight.priority = .defaultLow
        minHeight.isActive = true

        // Make sure stackView fills the width and uses reasonable hugging/compression priorities
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
    }
    
}


