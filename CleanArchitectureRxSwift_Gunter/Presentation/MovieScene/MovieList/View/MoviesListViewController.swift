//
//  MoviesListViewController.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

final class MoviesListViewController: BaseViewController, StoryboardInstantiable, Alertable {
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private var emptyLabel: UILabel!
    
    private var viewModel: MoviesListViewModel!
        
    static func create(with viewModel: MoviesListViewModel) -> MoviesListViewController {
        let view = MoviesListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("ViewDidAppear")
    }
    
    private func initView() {
        tableView.estimatedRowHeight = MoviesListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
        activityIndicator = UIActivityIndicatorView(frame:
            CGRect(
                x: UIScreen.main.bounds.size.width * 0.5,
                y: UIScreen.main.bounds.size.height * 0.5,
                width: 20,
                height: 20)
        )
        
        self.view.addSubview(activityIndicator)
    }
    
    private func setupRx() {
        assert(viewModel != nil )
        
        let query = searchBar.rx
            .text
            .orEmpty
            .changed
            .asDriver()
        
        let didSelect = tableView.rx
            .modelSelected(MoviesListItemViewModel.self)
            .asDriver()
        
        let input = MoviesListViewModel.Input(
            query: query,
            didSelectCell: didSelect
        )
        
        tableView.rx.reachedBottom()
            .do(onNext: { _ in
                log.debug("reachedBottom reachedBottom reachedBottom")
            })
            .bind(to: input.loadNextPageTrigger)
            .disposed(by: disposeBag)
                    
        let output = viewModel.transform(input: input)
        
        output.fetching
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.movies.asDriver(onErrorJustReturn: []).drive(
            tableView.rx.items(
                cellIdentifier: MoviesListItemCell.reuseIdentifier,
                cellType: MoviesListItemCell.self)) { _, viewModel, cell in
                    cell.bind(viewModel)
            }.disposed(by: disposeBag)
        
        output.error.drive(onNext: { (error) in
            log.error("error \(error)")
        }).disposed(by: disposeBag)
        
        output.didSelectCell
            .drive()
            .disposed(by: disposeBag)
    }
    
}
