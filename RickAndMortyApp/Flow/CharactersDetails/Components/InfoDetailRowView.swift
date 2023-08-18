//
//  InfoDetailRowView.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 17.08.2023.
//

import SwiftUI

struct InfoDetailRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color(Assets.Colors.grey ?? .grey))
            Spacer()
            Text(value)
                .foregroundStyle(.white)
        }
        .font(Font.system(size: 16))
        .padding([.leading, .trailing], 16)
    }
}

#Preview {
    InfoDetailRowView(title: "title", value: "value")
}
