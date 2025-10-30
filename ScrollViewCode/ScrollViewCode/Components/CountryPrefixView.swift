//
//  CountryPrefixView.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 30/10/25.
//

import Foundation
import UIKit

class CountryPrefixView: UIView {
    
    private let stackView : UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 4
        stackview.alignment = .center
        return stackview
    }()
    
     private let arrow: UIImageView = {
        let image = UIImageView(image: UIImage(named: "chevron"))
         image.contentMode = .scaleAspectFit
         image.widthAnchor.constraint(equalToConstant: 12).isActive = true
         return image
    }()
    
    let countryLabel: UILabel = {
        let flag = UILabel()
        flag.text = " 🇸🇬 +65 "
        flag.textColor = UIColor(hexString: "8D8D8D")
        flag.font = .systemFont(ofSize: 14, weight: .medium)
        return flag
    }()
           
    
    
    init() {
        super.init(frame: .zero)
        setpUI()
    }
    
    func setpUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(arrow)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
