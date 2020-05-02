//
//  MovieAPI.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

enum MovieAPI {
    case url(URL)
    
    case movies(param: MoviesRequestDTO)
}

extension MovieAPI: SugarTargetType {
    
    var baseURL: URL {
        return URL(string: "http://api.themoviedb.org/")!
    }
    
    var url: URL {
        switch self {
        case .url(let url):
            return url
        default:
            return self.defaultURL
        }
    }
    
    var route: Route {
        switch self {
        case .url:
            return .get("")
            
        case .movies:
            return .get("3/search/movie/")
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .movies(let param):
            return .init(encoding: URLEncoding.default, values: try! param.asDictionary())
            
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
      return ["Accept": "application/json"]
    }

    var sampleData: Data {
      return Data()
    }
    
}
