//
//  itemHero.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//

import Foundation

struct itemHero: Decodable, Identifiable {
    let id: Int
    let name: String
    let appearance: Appearance
    let biography: Biography
    let images: HeroImage

    var heroImageUrl: URL? {
        URL(string: images.sm ?? "")
    }

    struct Appearance: Decodable {
        let gender: String?
        let race: String?
        let height: [String]
        let weight: [String]
    }

    struct Biography: Decodable {
        let fullName: String?
        let firstAppearance: String?
        let placeOfBirth: String?
        let publisher: String?
        let alignment: String?
    }

    struct HeroImage: Decodable {
        let sm: String?
    }
}
