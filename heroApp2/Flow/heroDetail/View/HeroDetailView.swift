//
//  HeroDetailView.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import SwiftUI

struct HeroDetailView: View {
    @StateObject private var viewModel: HeroDetailViewModel
    let heroId: Int

    init(heroId: Int, service: HeroService) {
        _viewModel = StateObject(wrappedValue: HeroDetailViewModel(service: service))
        self.heroId = heroId
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let hero = viewModel.hero {
                Text(hero.name).font(.largeTitle)
            }
        }
        .task { await viewModel.fetchHeroDetails(id: heroId) }
    }
}
