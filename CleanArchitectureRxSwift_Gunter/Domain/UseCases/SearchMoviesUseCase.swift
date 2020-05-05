//
//  SearchMoviesUseCase.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift

protocol SearchMoviesUseCaseProtocol {
    func excute(query: MovieQuery, page: Int) -> Single<MoviesPage>
}

class SearchMoviesUseCase: DetectDeinit, SearchMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func excute(query: MovieQuery, page: Int) -> Single<MoviesPage> {
        return moviesRepository.fetchMovieList(query: query, page: page)
    }
    
}
