//
//  ViewController.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import SwiftUI

@MainActor
final class HeroListViewModel: ObservableObject {
    @Published private(set) var heroes: [HeroListModel] = []
    @Published private(set) var isLoading = false

    private let service: HeroService
    private let router: heroRouter

    init(service: HeroService, router: heroRouter) {
        self.service = service
        self.router = router
    }

    func fetchHeroesIfNeeded() async {
        guard !isLoading, heroes.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let heroesResponse = try await service.fetchHeroes()
            heroes = heroesResponse.map {
                HeroListModel(id: $0.id, title: $0.name, description: $0.biography.publisher ?? "Unknown", heroImage: $0.heroImageUrl)
            }
        } catch {
            print("Error loading heroes: \(error.localizedDescription)")
        }
    }

    func routeToDetail(by id: Int) {
        router.showDetails(for: id)
    }
}
