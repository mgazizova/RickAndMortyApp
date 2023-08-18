//
//  ActivityIndicatorCell.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import UIKit

class ActivityIndicatorCell: UICollectionViewCell {
    var indicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        contentView.addSubview(indicator)
        
        setConstraints()
        configure()
    }
    
    private func setConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 50),
            indicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configure() {
        indicator.startAnimating()
        indicator.color = .white
    }
}
