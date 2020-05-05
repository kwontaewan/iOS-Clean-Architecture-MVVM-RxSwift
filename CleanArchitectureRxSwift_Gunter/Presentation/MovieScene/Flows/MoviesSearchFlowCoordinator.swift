//
//  MoviesSearchFlowCoordinator.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

protocol MoviesSearchFlowCoordinatorDependencies {
    
    func makeMoviesListViewController(coordinator: MoviesSearchFlowCoordinator) -> MoviesListViewController
    
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController
}

protocol MoviesSearchFlowCoordinator {
    
    func start()
    
    func showMovieDetails(movie: Movie)
}

class DefaultMoviesSearchFlowCoordinator: MoviesSearchFlowCoordinator {
    
    private let navigationController: UINavigationController
    
    private let dependencies: MoviesSceneDIContainer
    
    private weak var moviesListVC: MoviesListViewController?
    
    init(navigationController: UINavigationController,
         dependencies: MoviesSceneDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMoviesListViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
        moviesListVC = vc
    }
    
    func showMovieDetails(movie: Movie) {
        
    }
    
}
