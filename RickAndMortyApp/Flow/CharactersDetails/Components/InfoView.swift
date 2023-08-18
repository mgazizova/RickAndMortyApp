//
//  InfoView.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import SwiftUI

struct InfoView: View {
    let species: String
    let type: String
    let gender: String
    
    var body: some View {
        VStack(spacing: 16) {
            InfoDetailRowView(title: "Species:", value: species)
            
            InfoDetailRowView(title: "Type:", value: type)
            
            InfoDetailRowView(title: "Gender:", value: gender)
        }
        .padding([.top, .bottom], 16)
        .background(Color(Assets.Colors.darkGrey ?? .darkGrey))
        .cornerRadius(16)
    }
}

#Preview {
    InfoView(species: "Human", type: "None", gender: "Male")
}
