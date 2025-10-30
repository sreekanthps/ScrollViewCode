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
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15 // Spacing between major sections/fields
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init () {
        super.init(frame: .zero)
        
    }
    
}


