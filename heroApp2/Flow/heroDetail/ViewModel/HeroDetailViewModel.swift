//
//  HeroDetailViewModel.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import SwiftUI

@MainActor
final class HeroDetailViewModel: ObservableObject {
    @Published private(set) var hero: itemHero?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: HeroService

    init(service: HeroService) {
        self.service = service
    }

    func fetchHeroDetails(id: Int) async {
        isLoading = true
        defer { isLoading = false }

        do {
            hero = try await service.fetchHeroById(id: id)
        } catch {
            errorMessage = "Failed to load hero."
        }
    }
}
