//
//  DisclaimerCheckboxView.swift
//  ScrollViewCode
//
//  Created by sreekanth pulicherla on 30/10/25.
//

import UIKit

class DisclaimerCheckboxView: UIView, UITextViewDelegate {

    // MARK: - Public
    var isChecked: Bool = false {
        didSet { updateCheckboxAppearance() }
    }

    /// Called when checkbox toggles
    var onCheckChanged: ((Bool) -> Void)?

    /// Called when one of the links is tapped. Argument will be one of "agreement" or "privacy".
    var onLinkTapped: ((String) -> Void)?

    // MARK: - Subviews
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainerInset = .zero
        tv.textContainer.lineFragmentPadding = 0
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = true
        tv.linkTextAttributes = [.foregroundColor: UIColor(hexString: "003dA5"), .font: UIFont.systemFont(ofSize: 14, weight: .semibold)]
        return tv
    }()

    private let containerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 8
        stackview.alignment = .top
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(containerStack)
        containerStack.addArrangedSubview(checkboxButton)
        containerStack.addArrangedSubview(textView)

        // Checkbox constraints
        NSLayoutConstraint.activate([
            checkboxButton.widthAnchor.constraint(equalToConstant: 30),
            checkboxButton.heightAnchor.constraint(equalToConstant: 30),
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        checkboxButton.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        textView.delegate = self

        // Default attributed text
        setupAttributedText()
        updateCheckboxAppearance()
    }

    // MARK: - Setup Text
    private func setupAttributedText() {
        let fullText = "I confirm that I have read, understood and accept NETS for Cardholders Agreement and Privacy Policy"
        let attributed = NSMutableAttributedString(string: fullText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5

        // base attributes
        let baseAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.label,
            .paragraphStyle: paragraphStyle
        ]
        attributed.addAttributes(baseAttrs, range: NSRange(location: 0, length: attributed.length))

        // link attributes - attach custom URLs we intercept in delegate
        let agreementRange = (fullText as NSString).range(of: "Cardholders Agreement")
        let privacyRange = (fullText as NSString).range(of: "Privacy Policy")
        if agreementRange.location != NSNotFound {
            attributed.addAttribute(.link, value: "action://agreement", range: agreementRange)
        }
        if privacyRange.location != NSNotFound {
            attributed.addAttribute(.link, value: "action://privacy", range: privacyRange)
        }

        textView.attributedText = attributed
        // Make text view behave like a label for accessibility
        textView.isAccessibilityElement = true
        textView.accessibilityTraits = .staticText
    }

    // MARK: - Actions
    @objc private func toggleCheckbox() {
        isChecked.toggle()
        onCheckChanged?(isChecked)
    }

    private func updateCheckboxAppearance() {
        let imageName = isChecked ? "checkbox" : "checkbox"
        let img = UIImage(named: imageName)
        checkboxButton.setImage(img, for: .normal)
    }

    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // Intercept our custom action URLs
        if URL.scheme == "action" {
            if URL.host == "agreement" {
                onLinkTapped?("agreement")
            } else if URL.host == "privacy" {
                onLinkTapped?("privacy")
            }
            return false
        }
        return true
    }
}
