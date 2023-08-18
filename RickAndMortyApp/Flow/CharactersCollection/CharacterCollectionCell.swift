//
//  CharacterCollectionCell.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    private lazy var imageView = UIImageView()
    private lazy var name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindView(with viewModel: CharacterViewModel) {
        let character = viewModel.character
        
        name.text = character.name
        ImageClient.shared.setImage(from: character.image,
                                    placeholderImage: nil) { [weak self] image in
            self?.imageView.image = image
        }
    }
}

private extension CharacterCollectionCell {
    func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        
        setConstraints()
        configure()
    }
    
    func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure() {
        name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        name.textColor = .white
        name.textAlignment = .center
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = Assets.Colors.darkGrey
    }
}
