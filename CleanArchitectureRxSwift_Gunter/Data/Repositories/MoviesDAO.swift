//
//  MoviesDAO.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift

class MoviesDAO: DetectDeinit, MoviesRepository {
    
    private let network: MovieNetworking
    
    init(network: MovieNetworking) {
        self.network = network
    }
    
    func fetchMovieList(query: MovieQuery, page: Int) -> Single<MoviesPage> {
        
        let requsetDTO = MoviesRequestDTO(query: query.query, page: page)
        
        return network
            .request(.movies(param: requsetDTO))
            .map(MoviesResponseDTO.self)
            .map{ $0.toDomain() }
            .do(onSuccess: { (response) in
                log.debug("response \(response.movies.count) page \(response.page)")
            })
    }
    
}
