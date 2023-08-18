//
//  OriginView.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import SwiftUI

struct OriginView: View {
    @Binding var origin: LocationDetails?
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 64, height: 64)
                    .background(Color(Assets.Colors.mirageGrey ?? .darkGrey))
                if let _ = origin {
                    Image(uiImage: Assets.Images.planet!)
                        .padding(20)
                } else {
                    ProgressView()
                        .tint(.white)
                }
                
            }
            .cornerRadius(10)
            .padding(8)
            
            ZStack {
                if let origin {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(origin.name)
                            .font(Font.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.bottom, 8)
                        Text(origin.type)
                            .font(Font.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(Assets.Colors.green ?? .green))
                    }
                }
            }
            Spacer()   
        }
        .background(Color(Assets.Colors.darkGrey ?? .darkGrey))
        .cornerRadius(16)
    }
}
