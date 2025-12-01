//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Abdallah Adel on 29/01/2025.
//
import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    // Glass background with fallback
    private lazy var glassBackground: UIView = createSafeBlurView(style: .systemUltraThinMaterial)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(glassBackground)
        getContentView(from: glassBackground).addSubviews(titleLabel, valueLabel)
        setUpLayer()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpLayer() {
        // Modern glass card
        contentView.layer.cornerRadius = 14
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        // Subtle glass border
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        
        // Soft shadow
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.08
        layer.masksToBounds = false
    }

    private func addConstraints() {
        let labelParent = getContentView(from: glassBackground)
        
        NSLayoutConstraint.activate([
            // Glass background fills cell
            glassBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            glassBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glassBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glassBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Title at top
            titleLabel.topAnchor.constraint(equalTo: labelParent.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: labelParent.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: labelParent.trailingAnchor, constant: -14),
            
            // Value below title
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: labelParent.leadingAnchor, constant: 14),
            valueLabel.trailingAnchor.constraint(equalTo: labelParent.trailingAnchor, constant: -14),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: labelParent.bottomAnchor, constant: -12),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }

    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title.uppercased()
        valueLabel.text = viewModel.value
    }
}
