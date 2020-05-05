//
//  MoviesListViewModel.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MoviesListViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        let query: Signal<String>
    }
    
    struct Output {
        let movies: Driver<[MoviesListItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let error: Driver<Error>
    }
    
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    private let coordinator: MoviesSearchFlowCoordinator

    init(searchMoviesUseCase: SearchMoviesUseCase,
         coordinator: MoviesSearchFlowCoordinator) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        
        let errorTracker = ErrorTracker()
    
        let movies = input.query.flatMapLatest { (query) -> Driver<[MoviesListItemViewModel]> in
            return self.searchMoviesUseCase
                .excute(query: MovieQuery(query: query), page: 1)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriver(onErrorJustReturn: MoviesPage(page: 1, totalPages: 0, movies: []))
                .map { $0.movies.map {MoviesListItemViewModel(with: $0)} }
        }
        
        let fetching = activityIndicator.asDriver()
        
        return Output(movies: movies,
                    fetching: fetching,
                    error: errorTracker.asDriver()
        )
        
    }
        
}
