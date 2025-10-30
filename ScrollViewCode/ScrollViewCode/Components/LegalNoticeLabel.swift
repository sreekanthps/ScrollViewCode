//
//  LegalNoticeLabel.swift
//  ScrollViewCode
//
//  Created by sreekanth pulicherla on 30/10/25.
//

import UIKit

class LegalNoticeLabel: UILabel {

    init(text: String? = nil) {
        super.init(frame: .zero)
        commonInit(text: text)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(text: nil)
    }

    private func commonInit(text: String?) {
        numberOfLines = 0
        font = UIFont.preferredFont(forTextStyle: .footnote)
        adjustsFontForContentSizeCategory = true
        textColor = UIColor.secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false

        let content = text ?? "The collection, use, disclosure and sharing of this information, which to the best of my knowledge and belief is true and accurate for purposes reasonably required to process my submission which are set out in NETS' Data protection policy."

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4

        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote),
            .foregroundColor: UIColor(hexString: "666666"),
            .paragraphStyle: paragraphStyle
        ]

        attributedText = NSAttributedString(string: content, attributes: attrs)
        accessibilityLabel = content
        accessibilityTraits = .staticText
    }
}
