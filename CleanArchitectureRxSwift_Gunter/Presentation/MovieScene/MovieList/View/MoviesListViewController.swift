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

final class MoviesListViewController: BaseViewController, StoryboardInstantiable, Alertable {
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    private func setupRx() {
        assert(viewModel != nil )
        
        let query = searchBar.rx
            .text
            .orEmpty
            .changed
            .asSignal()
            .debug()
        
        let input = MoviesListViewModel.Input(query: query)
        
        let output = viewModel.transform(input: input)
        
        output.movies.drive(
            tableView.rx.items(
                cellIdentifier: MoviesListItemCell.reuseIdentifier,
                cellType: MoviesListItemCell.self)) { _, viewModel, cell in
                    cell.bind(viewModel)
            }.disposed(by: disposeBag)
        
    }
    
}
