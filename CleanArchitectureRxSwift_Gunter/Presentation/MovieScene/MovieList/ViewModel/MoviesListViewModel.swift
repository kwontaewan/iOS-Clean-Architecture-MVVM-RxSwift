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
import RxSwiftExt

final class MoviesListViewModel: DetectDeinit, ViewModelType {
    
    let moives: BehaviorSubject<[MoviesListItemViewModel]> = BehaviorSubject<[MoviesListItemViewModel]>(value: [])
    
    let loading = BehaviorRelay<Bool>(value: false)
       
    var pageIndex: Int = 0
       
    let error = PublishSubject<Swift.Error>()
       
    let disposeBag = DisposeBag()
       
    var isAllLoaded = false
    
    struct Input {
        let query: Signal<String>
        
        let loadNextPageTrigger: PublishSubject<Void> = PublishSubject<Void>()
        
        let moives: BehaviorSubject<[MoviesListItemViewModel]> = BehaviorSubject<[MoviesListItemViewModel]>(value: [])
        
        let didSelectCell: Driver<MoviesListItemViewModel>
    }
    
    struct Output {
        let movies: BehaviorSubject<[MoviesListItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let didSelectCell: Driver<MoviesListItemViewModel>
        
        let error: Driver<Error>
    }
    
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    private let coordinator: MoviesSearchFlowCoordinator
    
    init(searchMoviesUseCase: SearchMoviesUseCase,
         coordinator: MoviesSearchFlowCoordinator) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        
        let errorTracker = ErrorTracker()
        
        let queryRequest = loading.asObservable()
            .sample(input.query.asObservable())
            .flatMap { (loading) -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { observer in
                        observer.onNext(1)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
        
        let nextPageRequest = loading.asObservable()
            .sample(input.loadNextPageTrigger)
            .flatMap { [unowned self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard !self.isAllLoaded else { return Observable.empty() }
                    
                    return Observable<Int>.create { [unowned self] observer in
                        self.pageIndex += 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
        
        let pageMerge = Observable.merge(queryRequest, nextPageRequest)
            .share(replay: 1)
        
        let request = Observable.combineLatest(pageMerge, input.query.asObservable())

        let response = request.flatMapLatest { [unowned self] (page, query)
            -> Observable<[MoviesListItemViewModel]> in
            
            return self.searchMoviesUseCase
                 .excute(query: MovieQuery(query: query), page: page)
                 .trackActivity(activityIndicator)
                 .trackError(errorTracker)
                 .map { $0.movies.map {MoviesListItemViewModel(with: $0)} }
            
        }
        
       Observable
        .combineLatest(request, response, moives.asObservable()) { [weak self] _, response, moives in
            self?.isAllLoaded = response.count < 20
            return self?.pageIndex == 1 ? response : moives + response
       }
       .sample(response)
       .bind(to: moives)
       .disposed(by: disposeBag)
        
        Observable
            .merge(request.map {_ in true },
                   response.map { _ in false },
                   error.map { _ in false })
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        let fetching = activityIndicator.asDriver()
        
        let didSelectCell = input.didSelectCell.do(onNext: { [weak self] (viewModel) in
            self?.coordinator.showMovieDetails(movie: viewModel.movie)
        })
        
        return Output(movies: moives,
                    fetching: fetching,
                    didSelectCell: didSelectCell,
                    error: errorTracker.asDriver()
        )
        
    }
        
}
