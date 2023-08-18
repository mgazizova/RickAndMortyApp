//
//  CharactersDetailsView.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 17.08.2023.
//

import SwiftUI

struct CharactersDetailsView: View {
    @ObservedObject var viewModel: CharactersDetailsDefaultViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                viewModel.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 148, height: 148)
                    .cornerRadius(16)
                    .padding(.bottom, 24)
                Text(viewModel.character.name)
                    .font(Font.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 8)
                Text(viewModel.character.status)
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(Assets.Colors.green ?? .green))
            }
            .padding(.bottom, 24)
            
            ScrollView {
                // MARK: Info
                HStack {
                    Text("Info")
                        .font(Font.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.bottom, 16)
                InfoView(species: viewModel.character.species,
                         type: viewModel.character.type.count == 0 ? "None" : viewModel.character.type,
                         gender: viewModel.character.gender)
                .padding(.bottom, 24)
                
                // MARK: Origin
                HStack {
                    Text("Origin")
                        .font(Font.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.bottom, 16)
                OriginView(origin: $viewModel.origin)
                    .padding(.bottom, 24)
                
                // MARK: Episodes
                HStack {
                    Text("Episodes")
                        .font(Font.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.bottom, 16)
                
                VStack(spacing: 16) {
                    ForEach($viewModel.episodes) {
                        EpisodeView(episode: $0)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
