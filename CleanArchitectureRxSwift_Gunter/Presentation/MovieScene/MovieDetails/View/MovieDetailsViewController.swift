//
//  MovieDetailsViewController.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/05.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: BaseViewController, StoryboardInstantiable {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    private var viewModel: MovieDetailsViewModel!
    
    static func create(with viewModel: MovieDetailsViewModel)
        -> MovieDetailsViewController {
        let view = MovieDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        assert(viewModel != nil )
        
        let input = MovieDetailsViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        posterImageView.setImage(with: PictureUrl.getPicUrl()+output.posterImgae)
        overviewTextView.text = output.overview
        
    }
    
}
