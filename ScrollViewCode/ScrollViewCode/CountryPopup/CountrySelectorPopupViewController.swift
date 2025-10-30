//
//  CountrySelectorPopupViewController.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit

class CountrySelectorPopupViewController: UIViewController {
    
    // MARK: - Data and State
    
    private var countries: [CountryCode] = [
        CountryCode(country: "Singapore", isd: "+65", flag: "🇸🇬", isDefault: true),
        CountryCode(country: "Malaysia", isd: "+60", flag: "🇲🇾", isDefault: false),
        CountryCode(country: "Thailand", isd: "+66", flag: "🇹🇭", isDefault: false),
        CountryCode(country: "Indonesia", isd: "+62", flag: "🇮🇩", isDefault: false),
        CountryCode(country: "Philippines", isd: "+63", flag: "🇵🇭", isDefault: false),
        CountryCode(country: "India", isd: "+91", flag: "🇮🇳", isDefault: false),
        CountryCode(country: "Australia", isd: "+61", flag: "🇦🇺", isDefault: false),
    ]
    
    private var selectedIndex: IndexPath = IndexPath(row: 0, section: 0) // Default to Singapore
    
    // MARK: - UI Components
    
    private let popupContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Country Code"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(CountryCodeCell.self, forCellReuseIdentifier: CountryCellID)
        tv.separatorStyle = .singleLine
        return tv
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set background to clear or semi-transparent for a modal effect
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        setupPopupLayout()
        
        // Set up Table View delegates and data source
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add action to the close button
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // Ensure rounding mask is applied after the final layout size is determined
        roundCorners(of: popupContainer, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15)
        }
    
    // MARK: - Layout Setup
    
    private func setupPopupLayout() {
        view.addSubview(popupContainer)
        popupContainer.addSubview(closeButton)
        popupContainer.addSubview(titleLabel)
        popupContainer.addSubview(tableView)
        
        // 1. Popup Container Constraints (Centered and fixed size)
        NSLayoutConstraint.activate([
            // Max width/height to prevent it from getting too large on big screens
            popupContainer.widthAnchor.constraint(equalToConstant: 350),
            popupContainer.heightAnchor.constraint(equalToConstant: 500),
            popupContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // 2. Close Button Constraints (Top Left)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: popupContainer.topAnchor, constant: 15),
            closeButton.leadingAnchor.constraint(equalTo: popupContainer.leadingAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // 3. Title Label Constraints (Centered horizontally below the close button)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: popupContainer.centerXAnchor),
        ])
        
        // 4. Table View Constraints (Fill remaining space)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: popupContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: popupContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: popupContainer.bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func dismissPopup() {
        // Custom way to dismiss the modal, e.g., using dismiss or removing from parent
        self.dismiss(animated: true, completion: nil)
    }
    
    private func roundCorners(of view: UIView, corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
        }
}

// MARK: - Table View Data Source and Delegate
extension CountrySelectorPopupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellID, for: indexPath) as? CountryCodeCell else {
            return UITableViewCell()
        }
        let countryCode = countries[indexPath.row]
        let isSelected = (indexPath == selectedIndex)
        
        // Highlight Singapore and check the selection state
        cell.configure(with: countryCode, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the previously selected row
        let oldIndexPath = selectedIndex
        if oldIndexPath != indexPath {
            tableView.reloadRows(at: [oldIndexPath], with: .automatic)
        }
        
        // Set the new selected index
        selectedIndex = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // Optional: Dismiss popup after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             self.dismissPopup()
        }
    }
}
