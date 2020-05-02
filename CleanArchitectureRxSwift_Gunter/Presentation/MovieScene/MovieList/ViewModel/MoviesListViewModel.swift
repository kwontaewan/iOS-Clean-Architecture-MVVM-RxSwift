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

final class MoviesListViewModel: ViewModelType {
    
    struct Input {
        let query: Signal<String>
    }
    
    struct Output {
        let movies: Driver<[MoviesListItemViewModel]>
    }
    
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    private let coordinator: MoviesSearchFlowCoordinator

    init(searchMoviesUseCase: SearchMoviesUseCase,
         coordinator: MoviesSearchFlowCoordinator) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let movies = input.query.flatMapLatest { (query) -> Driver<[MoviesListItemViewModel]> in
            return self.searchMoviesUseCase
                .excute(query: MovieQuery(query: query), page: 1)
                .asDriverOnErrorJustComplete()
                .map { $0.movies.map {MoviesListItemViewModel(with: $0)} }
        }
        
        return Output(movies: movies)
        
    }
        
}
