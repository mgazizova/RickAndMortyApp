//
//  CharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import UIKit
import SwiftUI

class CharactersCollectionViewController: UIViewController,
                                          UICollectionViewDelegate,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegateFlowLayout {
    private let charactersCollectionId = "CharacterCell"
    private let activityIndicatorId = "IndicatorCell"
    
    private var charactersCollection: UICollectionView?
    private var viewModel: CharactersCollectionViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    init(viewModel: CharactersCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CharactersCollectionViewController {
    func setup() {
        let layout = UICollectionViewFlowLayout()
        charactersCollection = UICollectionView(frame: .zero,
                                                collectionViewLayout: layout)
        view.addSubview(charactersCollection ?? UICollectionView())
        
        setConstraints()
        configure()
    }
    
    func setConstraints() {
        guard let charactersCollection else { return }
        
        charactersCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charactersCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            charactersCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            charactersCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            charactersCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure() {
        let title = UILabel()
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        title.text = "Characters"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        charactersCollection?.backgroundColor = .black
        charactersCollection?.register(CharacterCollectionCell.self,
                                       forCellWithReuseIdentifier: charactersCollectionId)
        charactersCollection?.register(ActivityIndicatorCell.self,
                                       forCellWithReuseIdentifier: activityIndicatorId)
        charactersCollection?.delegate = self
        charactersCollection?.dataSource = self
        
        viewModel.onFetchCharactersSucceed = updateCollection
    }
}

extension CharactersCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != viewModel.characters.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: charactersCollectionId,
                                                                for: indexPath) as? CharacterCollectionCell else {
                return UICollectionViewCell()
            }
            
            let character = viewModel.characters[indexPath.row]
            cell.bindView(with: CharacterDefaultViewModel(character: character))
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityIndicatorId,
                                                                for: indexPath) as? ActivityIndicatorCell else {
                return ActivityIndicatorCell()
            }
            cell.indicator.startAnimating()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let metainfo = viewModel.metainfo,
           indexPath.row == viewModel.characters.count,
           viewModel.characters.count < metainfo.count {
            viewModel.fetchNextCharacters()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let charactersCollection else {
            return CGSize(width: 100, height: 150)
        }
        let width = (charactersCollection.bounds.width - 16) / 2
        return CGSize(width: width,
                      height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let viewModel = CharactersDetailsDefaultViewModel(character: character)
        let view = CharactersDetailsView(viewModel: viewModel)
        
        ImageClient.shared.setImage(from: character.image,
                                    placeholderImage: nil) { image in
            guard let image else { return }
            viewModel.image = Image(uiImage: image)
        }
        
        if character.location.url == "" {
            viewModel.origin = LocationDetails(id: -1, name: "None", type: "None")
        } else {
            LocationClient.shared.setLocation(from: character.location.url) { location in
                guard let location else { return }
                viewModel.origin = location
            }
        }
        
        for episode in character.episode {
            EpisodeClient.shared.setEpisode(from: episode) { episode in
                guard let episode else { return }
                viewModel.episodes.append(episode)
            }
        }
        
        navigationController?.pushViewController(
            UIHostingController(rootView: view),
            animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

private extension CharactersCollectionViewController {
    func updateCollection() {
        DispatchQueue.main.async {
            self.charactersCollection?.reloadData()
        }
    }
}
