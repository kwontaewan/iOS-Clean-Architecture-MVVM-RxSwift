//
//  ViewModelType.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
