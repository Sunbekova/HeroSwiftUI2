//
//  ContentView.swift
//  HeroSwiftUI2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 06.03.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let hero = viewModel.selectedHero {
                VStack {
                    AsyncImage(url: URL(string: hero.images.md)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(hero.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    heroDetailView(title: "Full Name", value: hero.biography.fullName)
                    heroDetailView(title: "First Appearance", value: hero.biography.firstAppearance)
                    heroDetailView(title: "Publisher", value: hero.biography.publisher)
                    heroDetailView(title: "Alignment", value: hero.biography.alignment)
                    heroDetailView(title: "Place of Birth", value: hero.biography.placeOfBirth)
                    heroDetailView(title: "Gender", value: hero.appearance.gender)
                    heroDetailView(title: "Race", value: hero.appearance.race)
                    heroDetailView(title: "Height", value: hero.appearance.height.joined(separator: ", "))
                    heroDetailView(title: "Weight", value: hero.appearance.weight.joined(separator: ", "))
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                Text("Tap the button to fetch a hero")
            }
            
            Button("Roll Hero") {
                Task {
                    await viewModel.fetchHero()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
    
    @ViewBuilder
    private func heroDetailView(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .fontWeight(.bold)
            Text(value.isEmpty ? "Unknown" : value)
            Spacer()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
