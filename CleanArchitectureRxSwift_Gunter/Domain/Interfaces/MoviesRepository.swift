//
//  MoviesRepository.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift

protocol MoviesRepository {
    
    func fetchMovieList(query: MovieQuery, page: Int) -> Single<MoviesPage>
    
}
