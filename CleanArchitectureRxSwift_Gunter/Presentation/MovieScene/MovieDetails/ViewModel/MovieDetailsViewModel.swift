//
//  MovieDetailsViewModel.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/05.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

final class MovieDetailsViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let title: String
        let posterImgae: String
        let isPosterImageHidden: Bool
        let overview: String
    }
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func transform(input: Input) -> Output {
        return Output(
            title: movie.title ?? "",
            posterImgae: movie.posterPath ?? "",
            isPosterImageHidden: movie.posterPath == nil,
            overview: movie.overview ?? ""
        )
    }
    
}
