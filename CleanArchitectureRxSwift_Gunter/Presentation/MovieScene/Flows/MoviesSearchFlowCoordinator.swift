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
    
    func makeMovieDetailsViewController(movie: Movie) -> MovieDetailsViewController
}

protocol MoviesSearchFlowCoordinator {
    
    func start()
    
    func showMovieDetails(movie: Movie)
}

class DefaultMoviesSearchFlowCoordinator: MoviesSearchFlowCoordinator {
    
    private let navigationController: UINavigationController
    
    private let dependencies: MoviesSearchFlowCoordinatorDependencies
    
    private weak var moviesListVC: MoviesListViewController?
    
    init(navigationController: UINavigationController,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMoviesListViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
        //moviesListVC = vc
    }
    
    func showMovieDetails(movie: Movie) {
        let vc = dependencies.makeMovieDetailsViewController(movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
