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
                mainStack.distribution = .fill
                mainStack.translatesAutoresizingMaskIntoConstraints = false
                
                // Set content priorities for proper stretching
                flagLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                nameAndCodeStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
                checkmark.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                
                contentView.addSubview(mainStack)
                
                // Pin mainStack to cell edges with proper padding
                NSLayoutConstraint.activate([
                    mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                    mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                    mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
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
