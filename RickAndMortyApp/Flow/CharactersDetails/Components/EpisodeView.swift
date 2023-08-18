//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import SwiftUI

struct EpisodeView: View {
    @Binding var episode: EpisodeDetails
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(episode.name)
                    .font(Font.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(16)
            
            HStack {
                Text(episode.episode.toEpisode())
                    .font(Font.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(Assets.Colors.green ?? .green))
                Spacer()
                Text(episode.airDate)
                    .font(Font.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(Assets.Colors.dustGrey ?? .grey))
            }
            .padding([.leading, .trailing, .bottom], 16)
        }
        .background(Color(Assets.Colors.darkGrey ?? .darkGrey))
        .cornerRadius(16)
    }
}

private extension String {
    func toEpisode() -> String {
        let episode = Int(self.suffix(2))
        
        let start = self.index(self.startIndex, offsetBy: 1)
        let end = self.index(self.startIndex, offsetBy: 3)
        let season = Int(self[start..<end])
        
        if let episode, let season = season {
            return "Episode: \(episode), Season: \(season)"
        }
        return "None"
    }
}
