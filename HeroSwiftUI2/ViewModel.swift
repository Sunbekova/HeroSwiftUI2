//
//  ViewController.swift
//  HeroSwiftUI2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 06.03.2025.
//

import SwiftUI

struct Hero: Decodable {
    let name: String
    let biography: Biography
    let images: HeroImage
    let appearance: Appearance
    
    struct Biography: Decodable {
        let fullName: String
        let firstAppearance: String
        let placeOfBirth: String
        let publisher: String
        let alignment: String
    }
    
    struct Appearance: Decodable {
        let gender: String
        let race: String
        let height: [String]
        let weight: [String]
    }
    
    struct HeroImage: Decodable {
        let md: String
    }
}


final class ViewModel: ObservableObject {

    @Published var selectedHero: Hero?
    @Published var errorMessage: String?

    func fetchHero() async {
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json") else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
                errorMessage = nil
            }
        } catch {
            await MainActor.run {
                errorMessage = "Error: \(error.localizedDescription)"
            }
        }
    }

}

