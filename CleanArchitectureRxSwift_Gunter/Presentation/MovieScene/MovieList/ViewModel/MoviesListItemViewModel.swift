//
//  Movies.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct MoviesListItemViewModel: Equatable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
}

extension MoviesListItemViewModel {

    init(with movie: Movie) {
        self.title = movie.title ?? ""
        self.posterImagePath = movie.posterPath
        self.overview = movie.overview ?? ""
        if let releaseDate = movie.releaseDate {
            self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
        } else {
            self.releaseDate = NSLocalizedString("To be announced", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
