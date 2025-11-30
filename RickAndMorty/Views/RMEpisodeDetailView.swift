//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Abdallah Adel on 29/01/2025.
//
import UIKit

@MainActor
protocol RMEpisodeDetailViewDelegate: AnyObject {
    func rmEpisodeDetailView(
        _ detailView: RMEpisodeDetailView,
        didSelect character: RMCharacter
    )
}

// MARK: - Episode Header View

final class RMEpisodeHeaderView: UICollectionReusableView {
    static let identifier = "RMEpisodeHeaderView"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.layer.cornerCurve = .continuous
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return iv
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        layer.locations = [0.5, 1.0]
        return layer
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Episode Details"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
        ])
        
        // Load Rick image from URL
        loadRickImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }
    
    private func loadRickImage() {
        // Rick Sanchez image URL from the API
        let rickImageURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        
        URLSession.shared.dataTask(with: rickImageURL) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func configure(with episodeName: String?) {
        if let name = episodeName {
            titleLabel.text = name
        }
    }
}

// MARK: - Episode Detail View

final class RMEpisodeDetailView: UIView {

    public weak var delegate: RMEpisodeDetailViewDelegate?

    private var viewModel: RMEpisodeDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }

    private var collectionView: UICollectionView?

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createColectionView()
        addSubviews(collectionView, spinner)
        self.collectionView = collectionView
        addConstraints()

        spinner.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }

        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func createColectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RMEpisodeInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(RMEpisodeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: RMEpisodeHeaderView.identifier)
        return collectionView
    }

    // MARK: - Public

    public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
    }
}

extension RMEpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        let sectionType = sections[section]

        switch sectionType {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let sections = viewModel?.cellViewModels else {
            fatalError("No viewModel")
        }
        let sectionType = sections[indexPath.section]

        switch sectionType {
        case .information(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMEpisodeInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
        case .characters(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              indexPath.section == 0,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMEpisodeHeaderView.identifier,
                for: indexPath
              ) as? RMEpisodeHeaderView else {
            return UICollectionReusableView()
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel = viewModel else {
            return
        }
        let sections = viewModel.cellViewModels
        let sectionType = sections[indexPath.section]

        switch sectionType {
        case .information:
            break
        case .characters:
            guard let character = viewModel.character(at: indexPath.row) else {
                return
            }
            delegate?.rmEpisodeDetailView(self, didSelect: character)
        }
    }
}

extension RMEpisodeDetailView {
    func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout(withHeader: section == 0)
        }

        switch sections[section] {
        case .information:
            return createInfoLayout(withHeader: section == 0)
        case .characters:
            return createCharacterLayout()
        }
    }

    func createInfoLayout(withHeader: Bool = false) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(80)),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        
        // Add header for first section
        if withHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth((UIDevice.current.userInterfaceIdiom == .phone) ? 0.5 : 0.25),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute((UIDevice.current.userInterfaceIdiom == .phone) ? 260 : 320)
            ),
            subitems: (UIDevice.current.userInterfaceIdiom == .phone) ? [item, item] : [item, item, item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

