//
//  heroService.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//
import Foundation

protocol HeroService {
    func fetchHeroes() async throws -> [itemHero]
    func fetchHeroById(id: Int) async throws -> itemHero
}

struct HeroServiceImpl: HeroService {
    func fetchHeroes() async throws -> [itemHero] {
        try await fetchData(endpoint: "all.json")
    }

    func fetchHeroById(id: Int) async throws -> itemHero {
        try await fetchData(endpoint: "id/\(id).json")
    }

    private func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/\(endpoint)") else {
            throw HeroError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw HeroError.serverError
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum HeroError: Error, LocalizedError {
    case invalidURL, serverError, decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .serverError: return "Server error occurred."
        case .decodingFailed: return "Failed to decode data."
        }
    }
}
