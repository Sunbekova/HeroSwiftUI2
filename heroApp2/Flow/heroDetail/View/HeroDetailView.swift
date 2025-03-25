//
//  HeroDetailView.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import SwiftUI
import Kingfisher

struct HeroDetailView: View {
    @StateObject private var viewModel: HeroDetailViewModel
    let heroId: Int

    init(heroId: Int, service: HeroService) {
        _viewModel = StateObject(wrappedValue: HeroDetailViewModel(service: service))
        self.heroId = heroId
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let hero = viewModel.hero {
                    KFImage(hero.heroImageUrl)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, 10)

                    Text(hero.name)
                        .font(.largeTitle)
                        .bold()

                    detailRow(title: "Full Name", value: hero.biography.fullName)
                    detailRow(title: "First Appearance", value: hero.biography.firstAppearance)
                    detailRow(title: "Place of Birth", value: hero.biography.placeOfBirth)
                    detailRow(title: "Publisher", value: hero.biography.publisher)
                    detailRow(title: "Alignment", value: hero.biography.alignment)

                    Divider()

                    Text("Appearance")
                        .font(.title2)
                        .bold()
                    detailRow(title: "Gender", value: hero.appearance.gender)
                    detailRow(title: "Race", value: hero.appearance.race)
                    detailRow(title: "Height", value: hero.appearance.height.joined(separator: ", "))
                    detailRow(title: "Weight", value: hero.appearance.weight.joined(separator: ", "))
                } else {
                    Text("Hero not found.")
                }
            }
            .padding()
        }
        .task { await viewModel.fetchHeroDetails(id: heroId) }
        .navigationTitle("Hero Details")
    }

    @ViewBuilder
    private func detailRow(title: String, value: String?) -> some View {
        if let value = value, !value.isEmpty {
            HStack {
                Text(title + ":")
                    .fontWeight(.bold)
                Text(value)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

