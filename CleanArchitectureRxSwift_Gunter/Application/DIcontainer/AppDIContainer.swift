//
//  AppDIContainer.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

final class AppDIContainer {
    
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        let dependencies = MoviesSceneDIContainer.Dependencies(movieNetworking: MovieNetworking())
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
    
}
