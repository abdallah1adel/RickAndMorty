//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 29/01/2025.
//
import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterPhotoCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Gradient overlay for depth
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor
        ]
        layer.locations = [0.6, 1.0]
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGlassStyle()
        contentView.addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupGlassStyle() {
        // Rounded corners with glass border
        contentView.layer.cornerRadius = 24
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        // Glass border
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        // Floating shadow
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }
}
