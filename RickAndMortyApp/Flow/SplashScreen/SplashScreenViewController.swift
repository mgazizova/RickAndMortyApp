//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private lazy var stars = UIImageView(image: Assets.Images.stars)
    private lazy var portal = UIImageView(image: Assets.Images.portal)
    private lazy var rickAndMortyTitle = UIImageView(image: Assets.Images.rickAndMorty)
    
    private var viewModel: CharactersCollectionViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
        fetchCharacters()
    }
    
    init(viewModel: CharactersCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchCharacters() {
        viewModel.fetchCharacters()
    }
    
    private func setup() {
        view.addSubview(stars)
        view.addSubview(portal)
        view.addSubview(rickAndMortyTitle)
        
        setConstraints()
        configure()
    }
    
    private func setConstraints() {
        stars.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stars.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stars.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stars.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stars.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        rickAndMortyTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rickAndMortyTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rickAndMortyTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            rickAndMortyTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        portal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            portal.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            portal.topAnchor.constraint(equalTo: rickAndMortyTitle.bottomAnchor, constant: 36)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .black
        viewModel.onFetchCharactersSucceed = goToCharacterListView
    }
    
    private func goToCharacterListView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.navigationController?.setViewControllers(
                [CharactersCollectionViewController(viewModel: self.viewModel)],
                animated: true)
        }
    }
}
