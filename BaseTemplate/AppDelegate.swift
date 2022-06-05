//
//  AppDelegate.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import UIKit
import RxFlow
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let disposeBag = DisposeBag()
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    let photosService = PhotosService()
    let albumsService = AlbumsService()

    lazy var appServices = {
        return AppServices(
            photosService: self.photosService,
            albumsService: self.albumsService
        )
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = self.window else { return false }

        self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)

        self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)

        let appFlow = AppFlow(services: self.appServices)

        self.coordinator.coordinate(flow: appFlow, with: OneStepper(withSingleStep: AppStep.albumsAreRequired))

        Flows.use(appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }

        UNUserNotificationCenter.current().delegate = self

        return true
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler(UNNotificationPresentationOptions.init(arrayLiteral: [.alert, .badge]))
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // example of how DeepLink can be handled
        // self.coordinator.navigate(to: AppStep.albumPicked(with id: 1))
    }
}

struct AppServices: HasPhotosService, HasAlbumsService {
    let photosService: PhotosService
    let albumsService: AlbumsService
}
