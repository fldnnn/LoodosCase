//
//  MovieDetailViewController.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var movieOpaqueImgView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imdbRateLbl: UILabel!
    @IBOutlet weak var plotLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        blurView.alpha = 0.7
        blurView.backgroundColor = .black
        blurView.isHidden = true
        movieOpaqueImgView.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = movieOpaqueImgView.bounds
        movieOpaqueImgView.addSubview(blurView)
        
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backButtonTapped))
        let add = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [add, backButton]
        navigationController?.navigationBar.tintColor = UIColor.black
    
        titleLbl.text = ""
        yearLbl.text = ""
        countryLabel.text = ""
        imdbRateLbl.text = ""
        plotLbl.text = ""
        directorLbl.text = ""
        genreLbl.text = ""
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showMovieDetail(_ movieDetail: MovieDetail) {
        titleLbl.text = movieDetail.title
        yearLbl.text = movieDetail.year
        if let country = movieDetail.country, let imdbrating = movieDetail.imdbRating {
            countryLabel.text = "Country: \(country)"
            imdbRateLbl.text = "Imdb: \(imdbrating)/10"
        }
        plotLbl.text = movieDetail.plot
        directorLbl.text = movieDetail.director
        genreLbl.text = movieDetail.genre
        
        if let poster = movieDetail.poster, let url = URL(string: poster) {
            movieImgView.kf.setImage(with: url)
            movieOpaqueImgView.kf.setImage(with: url)
        } else {
            movieImgView.image = UIImage(named: "placeholder")
        }
    }
    
    func showError(_ message: String) {
        showAlert(title: "Hata", message: message)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
