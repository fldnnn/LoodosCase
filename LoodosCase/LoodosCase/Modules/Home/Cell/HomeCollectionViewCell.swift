//
//  HomeCollectionViewCell.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieYearLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        movieImgView.contentMode = .scaleToFill
        movieImgView.clipsToBounds = true
        movieImgView.layer.masksToBounds = true
        movieImgView.layer.cornerRadius = 5
    }
    
    func configure(with movie: Movie) {
        movieTitleLbl.text = movie.title
        movieYearLbl.text = movie.year
        if let poster = movie.poster, let url = URL(string: poster), !poster.isEmpty {
            movieImgView.kf.setImage(with: url)
        } else {
            movieImgView.image = UIImage(named: "filmdefault")
        }
    }
}
