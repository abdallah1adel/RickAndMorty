//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by pcpos on 03/05/2024.
//

import UIKit

/// Single cell for charcater
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = .label
        Label.font = .systemFont(ofSize: 18,weight: .medium)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    
    private let statusLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = .secondaryLabel
        Label.font = .systemFont(ofSize: 16,weight: .regular)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    // MARK - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView,nameLabel,statusLabel)
        addConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
            
            
        ])
       // imageView.backgroundColor = .systemCyan
       // nameLabel.backgroundColor = .red
       // statusLabel.backgroundColor = .orange
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel : RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.charecterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage {[weak self] result in
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
}

