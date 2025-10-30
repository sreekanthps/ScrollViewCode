//
//  CountrycodeCell.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit

// --- Data Structure ---
struct CountryCode {
    let country: String
    let isd: String
    let flag: String
    let isDefault: Bool
}

// --- Cell Identifier ---
public let CountryCellID = "CountryCell"

// --- Custom Cell Class ---
class CountryCodeCell: UITableViewCell {
    
    // Components
    let flagLabel = UILabel()
    let countryLabel = UILabel()
    let isdLabel = UILabel()
    let checkmark = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup appearance
                flagLabel.font = UIFont.systemFont(ofSize: 24)
                countryLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
                isdLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
                checkmark.tintColor = .systemBlue
                
                // 1. NESTED STACK: Group Country Name and ISD Code
                let nameAndCodeStack = UIStackView(arrangedSubviews: [countryLabel, isdLabel])
                nameAndCodeStack.axis = .horizontal
                nameAndCodeStack.spacing = 10
                countryLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
                isdLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                
                // 2. MAIN STACK: Organize Flag, Nested Stack, and Checkmark
                let mainStack = UIStackView(arrangedSubviews: [flagLabel, nameAndCodeStack, checkmark])
                mainStack.axis = .horizontal
                mainStack.spacing = 15
                mainStack.alignment = .center
                mainStack.translatesAutoresizingMaskIntoConstraints = false
                
                // The main stack needs an empty spacer to push content to the left
                let spacer = UIView()
                spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
                mainStack.insertArrangedSubview(spacer, at: 2)
                
                contentView.addSubview(mainStack)
                
                // 3. APPLY PADDING using Layout Margins
                mainStack.isLayoutMarginsRelativeArrangement = true
                // CRITICAL FIX: Add leading padding (e.g., 20 points)
                mainStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                
                // Pin mainStack to cell edges
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                    mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                    // Pin the stack's layout margin edges, not the stack itself, to the content view.
                    mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with code: CountryCode, isSelected: Bool) {
        flagLabel.text = code.flag
        countryLabel.text = code.country
        isdLabel.text = code.isd
        
        // Hide/Show checkmark
        checkmark.isHidden = !isSelected
    }
       
}
