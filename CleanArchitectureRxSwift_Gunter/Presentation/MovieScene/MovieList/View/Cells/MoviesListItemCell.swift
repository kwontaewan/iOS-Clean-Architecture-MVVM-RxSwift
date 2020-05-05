//
//  MoviesListItemCell.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/02.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class MoviesListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: MoviesListItemCell.self)
    
    static let height = CGFloat(130)
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ viewModel: MoviesListItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.dateLabel.text = viewModel.releaseDate
        self.overViewLabel.text = viewModel.overview
        self.posterImageView.setImage(with:
            PictureUrl.getPicUrl()+(viewModel.posterImagePath ?? "")
        )
        
    }
}
