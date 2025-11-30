//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//
import UIKit

/// Single cell for a character with Liquid Glass styling
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Glass overlay for text area
    private let glassOverlay: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Status indicator dot
    private let statusDot: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupGlassCard()
        contentView.addSubviews(imageView, glassOverlay)
        glassOverlay.contentView.addSubviews(statusDot, nameLabel, statusLabel)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setupGlassCard() {
        // Modern rounded corners
        contentView.layer.cornerRadius = 20
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        // Outer container for shadow (since clipsToBounds is true)
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        
        // Glass border effect
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        // Floating shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Image fills the card
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Glass overlay at bottom
            glassOverlay.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            glassOverlay.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            glassOverlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            glassOverlay.heightAnchor.constraint(equalToConstant: 60),
            
            // Status dot
            statusDot.widthAnchor.constraint(equalToConstant: 8),
            statusDot.heightAnchor.constraint(equalToConstant: 8),
            statusDot.leftAnchor.constraint(equalTo: glassOverlay.contentView.leftAnchor, constant: 12),
            statusDot.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: glassOverlay.contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: glassOverlay.contentView.leftAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: glassOverlay.contentView.rightAnchor, constant: -12),
            
            // Status label with dot spacing
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.leftAnchor.constraint(equalTo: statusDot.rightAnchor, constant: 6),
            statusLabel.rightAnchor.constraint(equalTo: glassOverlay.contentView.rightAnchor, constant: -12),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
        statusDot.backgroundColor = .clear
    }

    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        
        // Update status indicator color
        updateStatusColor(from: viewModel.characterStatusText)
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    private func updateStatusColor(from statusText: String) {
        let lowercased = statusText.lowercased()
        if lowercased.contains("alive") {
            statusDot.backgroundColor = LiquidGlassTheme.aliveGlass
            statusLabel.textColor = LiquidGlassTheme.aliveGlass
        } else if lowercased.contains("dead") {
            statusDot.backgroundColor = LiquidGlassTheme.deadGlass
            statusLabel.textColor = LiquidGlassTheme.deadGlass
        } else {
            statusDot.backgroundColor = LiquidGlassTheme.unknownGlass
            statusLabel.textColor = LiquidGlassTheme.unknownGlass
        }
        
        // Add glow to status dot
        statusDot.layer.shadowColor = statusDot.backgroundColor?.cgColor
        statusDot.layer.shadowOffset = .zero
        statusDot.layer.shadowRadius = 4
        statusDot.layer.shadowOpacity = 0.8
    }
    
    // MARK: - Interaction Animation
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.96, y: 0.96) : .identity
                self.alpha = self.isHighlighted ? 0.9 : 1.0
            }
        }
    }
}
