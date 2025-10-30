//
//  PasswordRulesView.swift
//  ScrollViewCode
//
//  Created by automated-refactor on 30/10/25.
//

import Foundation
import UIKit

/// A reusable view that displays password rules with checkmarks and exposes an API
/// to mark rules as satisfied. Each rule row is accessible and supports Dynamic Type.
class PasswordRulesView: UIView {

    // MARK: - Public API
    /// The rules shown by the view (read-only).
    private(set) var rules: [String]

    /// Current checked state for each rule.
    private(set) var checked: [Bool]

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your password must contain:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var rowStacks: [UIStackView] = []
    private var checkmarks: [UIImageView] = []
    private var labels: [UILabel] = []

    // MARK: - Init
    init(rules: [String] = [
        "At least 8 alphanumeric characters",
        "One uppercase character",
        "One lowercase character",
        "One number",
        "Confirm new password matches"
    ]) {
        self.rules = rules
        self.checked = Array(repeating: false, count: rules.count)
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.rules = []
        self.checked = []
        super.init(coder: coder)
        // If used from IB, nothing to populate by default
        setup()
    }

    // MARK: - Setup
    private func setup() {
        addSubview(stackView)

        // Title
        stackView.addArrangedSubview(titleLabel)

        // Rows
        for (index, rule) in rules.enumerated() {
            let row = makeRow(text: rule, index: index)
            rowStacks.append(row)
            stackView.addArrangedSubview(row)
        }

        // Constrain stack
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func makeRow(text: String, index: Int) -> UIStackView {
        let itemStack = UIStackView()
        itemStack.axis = .horizontal
        itemStack.alignment = .center
        itemStack.spacing = 8
        itemStack.translatesAutoresizingMaskIntoConstraints = false

        let check = UIImageView(image: UIImage(named: "uncheck"))
        check.tintColor = .systemBlue
        check.contentMode = .scaleAspectFit
        check.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            check.widthAnchor.constraint(equalToConstant: 16),
            check.heightAnchor.constraint(equalToConstant: 16)
        ])

        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        // Accessibility: expose row as single element
        itemStack.isAccessibilityElement = true
        itemStack.accessibilityLabel = text
        itemStack.accessibilityTraits = .staticText

        itemStack.addArrangedSubview(check)
        itemStack.addArrangedSubview(label)

        checkmarks.append(check)
        labels.append(label)

        return itemStack
    }

    // MARK: - State API
    /// Mark a rule as checked or unchecked
    func setChecked(_ index: Int, _ value: Bool, animated: Bool = false) {
        guard index >= 0, index < checkmarks.count else { return }
        checked[index] = value
        let imageName = value ? "check" : "uncheck"
        let image = UIImage(named: imageName)
        let check = checkmarks[index]
        if animated {
            UIView.transition(with: check, duration: 0.18, options: .transitionCrossDissolve, animations: {
                check.image = image
            }, completion: nil)
        } else {
            check.image = image
        }
        // Update accessibility value
        check.accessibilityLabel = value ? "completed" : "not completed"
    }

    /// Mark all rules at once
    func setCheckedStates(_ states: [Bool]) {
        for (i, v) in states.enumerated() {
            setChecked(i, v)
        }
    }

    /// Return boolean indicating whether all rules are satisfied
    var allSatisfied: Bool {
        return !checked.contains(false)
    }
}
