//
//  AppStep.swift
//  BaseTemplate
//
//  Created by @hellc on 05.06.2022.
//

import RxFlow

enum AppStep: Step {
    // Global
    case logoutIsRequired
    case dashboardIsRequired
    case alert(String)
    case fakeStep
    case unauthorized

    // Albums
    case albumsAreRequired
    case albumIsPicked(albumId: Int)
    case albumLoadFailed

    // Photos
    case photoIsPicked(photoId: Int)
}
