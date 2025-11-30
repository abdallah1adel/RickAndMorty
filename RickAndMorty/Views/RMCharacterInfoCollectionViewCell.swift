//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 29/01/2025.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterInfoCollectionViewCell"
    
    // Glass background
    private let glassBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()

    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    // Icon container with glass pill
    private let iconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupGlassStyle()
        contentView.addSubview(glassBackground)
        glassBackground.contentView.addSubviews(iconContainer, valueLabel, titleLabel)
        iconContainer.addSubview(iconImageView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupGlassStyle() {
        // Modern glass card
        contentView.layer.cornerRadius = 16
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        // Glass border
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        
        // Shadow for depth
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            // Glass background
            glassBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            glassBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glassBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glassBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Icon container at top center
            iconContainer.topAnchor.constraint(equalTo: glassBackground.contentView.topAnchor, constant: 16),
            iconContainer.centerXAnchor.constraint(equalTo: glassBackground.contentView.centerXAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            // Icon centered in container
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22),
            
            // Value label in middle
            valueLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: glassBackground.contentView.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: glassBackground.contentView.trailingAnchor, constant: -8),
            
            // Title at bottom
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: glassBackground.contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: glassBackground.contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: glassBackground.contentView.bottomAnchor, constant: -12),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        iconContainer.backgroundColor = .clear
    }

    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title.uppercased()
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        
        let tintColor = viewModel.tintColor
        iconImageView.tintColor = tintColor
        valueLabel.textColor = .label
        
        // Glass pill background for icon
        iconContainer.backgroundColor = tintColor.withAlphaComponent(0.15)
        iconContainer.layer.borderWidth = 1
        iconContainer.layer.borderColor = tintColor.withAlphaComponent(0.3).cgColor
    }
}
