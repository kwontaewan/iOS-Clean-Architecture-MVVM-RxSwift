//
//  MovieRequestDTO+Mapping.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct MoviesRequestDTO: ModelType {
    
    let query: String
    let page: Int
    let api_key: String = "2696829a81b1b5827d515ff121700838"
    let language: String = "en"
    
}
