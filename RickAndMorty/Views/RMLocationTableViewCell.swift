//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 29/01/2025.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    static let cellIdentifier = "RMLocationTableViewCell"
    
    // Location icon
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "globe.americas.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = LiquidGlassTheme.portalBlue
        return imageView
    }()
    
    // Glass icon container
    private let iconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = LiquidGlassTheme.portalBlue.withAlphaComponent(0.15)
        view.layer.cornerRadius = 22
        view.layer.cornerCurve = .continuous
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = LiquidGlassTheme.portalGreen
        return label
    }()

    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    // Chevron indicator
    private let chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel
        return imageView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        contentView.addSubviews(iconContainer, nameLabel, typeLabel, dimensionLabel, chevronIcon)
        iconContainer.addSubview(locationIcon)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // Remove default accessory
        accessoryType = .none
        
        // Selection style
        let selectedView = UIView()
        selectedView.backgroundColor = LiquidGlassTheme.portalGreen.withAlphaComponent(0.1)
        selectedBackgroundView = selectedView
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Icon container
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 44),
            iconContainer.heightAnchor.constraint(equalToConstant: 44),
            
            // Location icon inside container
            locationIcon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            locationIcon.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: 22),
            locationIcon.heightAnchor.constraint(equalToConstant: 22),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: -12),
            
            // Type label (as pill badge style)
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 14),
            
            // Dimension label
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            dimensionLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 14),
            dimensionLabel.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: -12),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            // Chevron
            chevronIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chevronIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 12),
            chevronIcon.heightAnchor.constraint(equalToConstant: 16),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }

    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        typeLabel.text = "📍 " + viewModel.type
        dimensionLabel.text = "🌌 " + viewModel.dimension
        
        // Randomize icon color for variety
        let colors: [UIColor] = [
            LiquidGlassTheme.portalBlue,
            LiquidGlassTheme.portalGreen,
            LiquidGlassTheme.cosmicPurple,
            LiquidGlassTheme.dimensionPink
        ]
        let randomColor = colors.randomElement() ?? LiquidGlassTheme.portalBlue
        locationIcon.tintColor = randomColor
        iconContainer.backgroundColor = randomColor.withAlphaComponent(0.15)
    }
}
