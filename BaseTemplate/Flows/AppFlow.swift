//
//  AppFlow.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

class AppFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .albumsAreRequired:
            return navigationToAlbumsScreen()
        default:
            return .none
        }
    }

    private func navigationToAlbumsScreen() -> FlowContributors {

        let albumsFlow = AlbumsFlow(withServices: self.services)

        Flows.use(albumsFlow, when: .created) { [unowned self] root in
            root.modalPresentationStyle = .overFullScreen
            DispatchQueue.main.async {
                self.rootViewController.present(root, animated: false)
            }
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: albumsFlow,
            withNextStepper: OneStepper(withSingleStep: AppStep.albumsAreRequired))
        )
    }
}
