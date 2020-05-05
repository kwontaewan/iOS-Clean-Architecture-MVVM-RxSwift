//
//  ApiError.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/04.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct APIErrorResponse: Decodable {
    let errors: [String]
}

enum APIError: Error  {
    
    case apiKeyExpired
    
    case with(message: String)
    
    init(stautsCode: Int, message: String) {
        switch stautsCode {
        case 500:
            self = .apiKeyExpired
        default:
            self = .with(message: message)
        }
    }
    
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiKeyExpired:
            return NSLocalizedString("he API key has expired. Please contact the developer.", comment: "")
        case .with(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func catchAPIError(_ type: APIErrorResponse.Type) -> Single<Element> {
        return flatMap { response in
            guard (200...299).contains(response.statusCode) else {
                do {
                    let apiErrorResponse = try response.map(type.self)
                    throw APIError(stautsCode: 0, message: apiErrorResponse.errors.first ?? "")
                } catch {
                    throw error
                }
            }
            
            return .just(response)
            
        }
    }
    
}
