//
//  heroRouter.swift
//  heroApp2
//
//  Created by Aisha Suanbekova Bakytjankyzy on 25.03.2025.
//
import UIKit
import SwiftUI

final class heroRouter {
    var rootViewController: UINavigationController?
    private let service: HeroService

    init(service: HeroService = HeroServiceImpl()) {
        self.service = service
    }

    func showDetails(for id: Int) {
        let detailView = HeroDetailView(heroId: id, service: service)
        let detailVC = UIHostingController(rootView: detailView)
        rootViewController?.pushViewController(detailVC, animated: true)
    }
}
