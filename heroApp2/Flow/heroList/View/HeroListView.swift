//
//  HeroListView.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import SwiftUI
import Kingfisher

struct HeroListView: View {
    @StateObject private var viewModel: HeroListViewModel

    init(service: HeroService, router: heroRouter) {
        _viewModel = StateObject(wrappedValue: HeroListViewModel(service: service, router: router))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.heroes) { model in
                        heroCard(model: model)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .task { await viewModel.fetchHeroesIfNeeded() }
            .navigationTitle("Heroes")
        }
    }

    @ViewBuilder
    private func heroCard(model: HeroListModel) -> some View {
        HStack {
            KFImage(model.heroImage)
                .resizable()
                .placeholder { ProgressView() }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 16)

            VStack(alignment: .leading) {
                Text(model.title).font(.headline)
                Text(model.description).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { viewModel.routeToDetail(by: model.id) }
    }
}
