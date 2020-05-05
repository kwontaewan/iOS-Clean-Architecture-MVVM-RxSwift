//
//  MoviesSceneDIContainer.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let movieNetworking: MovieNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchMovieUseCase() -> SearchMoviesUseCase {
        return SearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        return MoviesDAO(network: dependencies.movieNetworking)
    }
    
    // MARK: - Movies List
    func makeMoviesListViewController(
        coordinator: MoviesSearchFlowCoordinator
    ) -> MoviesListViewController {
        MoviesListViewController.create(
            with: makeMoviesListViewModel(coordinator: coordinator)
        )
    }
    
    func makeMoviesListViewModel(
        coordinator: MoviesSearchFlowCoordinator
    ) -> MoviesListViewModel {
        return MoviesListViewModel(
            searchMoviesUseCase: makeSearchMovieUseCase(),
            coordinator: coordinator
        )
    }
    
    // MARK: - Movies Detail
    func makeMovieDetailsViewController(
        movie: Movie
    ) -> MovieDetailsViewController {
        return MovieDetailsViewController.create(
            with: makeMoviesDetailsViewModel(movie: movie)
        )
    }
    
    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movie: movie)
    }
        
    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(
        navigationController: UINavigationController
    ) -> MoviesSearchFlowCoordinator {
        return DefaultMoviesSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {}
