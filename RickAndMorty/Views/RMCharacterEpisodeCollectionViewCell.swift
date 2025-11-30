//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 29/01/2025.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterEpisodeCollectionViewCell"
    
    // Glass background
    private let glassBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Accent color bar on left
    private let accentBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        return view
    }()
    
    // Episode icon
    private let episodeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = LiquidGlassTheme.portalGreen
        return imageView
    }()

    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupGlassStyle()
        contentView.addSubview(glassBackground)
        glassBackground.contentView.addSubviews(accentBar, episodeIcon, seasonLabel, nameLabel, airDateLabel)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupGlassStyle() {
        // Modern glass card appearance
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
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            // Glass background fills cell
            glassBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            glassBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            glassBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            glassBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Accent bar on left
            accentBar.leadingAnchor.constraint(equalTo: glassBackground.contentView.leadingAnchor, constant: 12),
            accentBar.topAnchor.constraint(equalTo: glassBackground.contentView.topAnchor, constant: 12),
            accentBar.bottomAnchor.constraint(equalTo: glassBackground.contentView.bottomAnchor, constant: -12),
            accentBar.widthAnchor.constraint(equalToConstant: 4),
            
            // Episode icon
            episodeIcon.trailingAnchor.constraint(equalTo: glassBackground.contentView.trailingAnchor, constant: -16),
            episodeIcon.centerYAnchor.constraint(equalTo: glassBackground.contentView.centerYAnchor),
            episodeIcon.widthAnchor.constraint(equalToConstant: 32),
            episodeIcon.heightAnchor.constraint(equalToConstant: 32),
            
            // Season label
            seasonLabel.topAnchor.constraint(equalTo: glassBackground.contentView.topAnchor, constant: 14),
            seasonLabel.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: 12),
            seasonLabel.trailingAnchor.constraint(equalTo: episodeIcon.leadingAnchor, constant: -12),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: episodeIcon.leadingAnchor, constant: -12),
            
            // Air date label
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            airDateLabel.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: 12),
            airDateLabel.trailingAnchor.constraint(equalTo: episodeIcon.leadingAnchor, constant: -12),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
        accentBar.backgroundColor = .clear
    }

    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            DispatchQueue.main.async {
                self?.nameLabel.text = data.name
                self?.seasonLabel.text = data.episode.uppercased()
                self?.airDateLabel.text = "📅 " + data.air_date
            }
        }
        viewModel.fetchEpisode()
        
        // Set accent color with glow
        let accentColor = viewModel.borderColor
        accentBar.backgroundColor = accentColor
        accentBar.layer.shadowColor = accentColor.cgColor
        accentBar.layer.shadowOffset = .zero
        accentBar.layer.shadowRadius = 4
        accentBar.layer.shadowOpacity = 0.6
        
        episodeIcon.tintColor = accentColor
    }
    
    // MARK: - Interaction Animation
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut]) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
                self.alpha = self.isHighlighted ? 0.85 : 1.0
            }
        }
    }
}
