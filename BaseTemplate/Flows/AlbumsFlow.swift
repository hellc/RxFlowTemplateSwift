//
//  WishlistFlow.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import RxFlow
import UIKit

class AlbumsFlow: Flow {
    var root: Presentable {
        self.rootViewController.view.backgroundColor = .cyan
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()
    private let services: AppServices

    init(withServices services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {

        guard let step = step as? AppStep else { return .none }

        switch step {
        case .albumsAreRequired:
            return navigateToAlbumsScreen()
        case .albumIsPicked(let albumId):
            return navigateToAlbumScreen(with: albumId)
        case .albumLoadFailed:
            return closeAlbum()
        default:
            return .none
        }
    }

    private func navigateToAlbumsScreen() -> FlowContributors {
        let viewController = AlbumsViewController.instantiate(
            withViewModel: AlbumsViewModel(),
            andServices: self.services
        )
        viewController.title = "Albums"
        viewController.modalPresentationStyle = .none

        self.rootViewController.setViewControllers([viewController], animated: false)
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        )
    }

    private func navigateToAlbumScreen(with albumId: Int) -> FlowContributors {
        let viewController = AlbumViewController.instantiate(
            withViewModel: AlbumViewModel(albumId: albumId), andServices: self.services
        )
        viewController.title = "Album \(viewController.viewModel.albumId)"
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel)
        )
    }

    private func closeAlbum() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
}
