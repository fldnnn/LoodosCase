//
//  MovieDetailViewController.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit
import FirebaseAnalytics

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol, ImageTransitionable {
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
    @IBOutlet weak var directorDefaultLbl: UILabel!
    @IBOutlet weak var genreDefaultLbl: UILabel!
    
    var initialImage: UIImage? {
        didSet {
            if isViewLoaded {
                movieImgView.image = initialImage
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
        
        if let image = initialImage {
            movieImgView.image = image
        }
    }
    
    private func setupUI() {
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        blurView.alpha = 0.3
        blurView.backgroundColor = .black
//        blurView.isHidden = true
        movieOpaqueImgView.contentMode = .scaleAspectFill
        movieImgView.clipsToBounds = true
        movieImgView.layer.masksToBounds = true
        movieImgView.layer.cornerRadius = 5
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = movieOpaqueImgView.bounds
        movieOpaqueImgView.addSubview(blurView)
        
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(red: 92/255, green: 167/255, blue: 183/255, alpha: 1.0)
        let add = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withTintColor(UIColor(red: 92/255, green: 167/255, blue: 183/255, alpha: 1.0), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [add, backButton]
        navigationController?.navigationBar.tintColor = UIColor.white
    
        titleLbl.text = ""
        yearLbl.text = ""
        countryLabel.text = ""
        imdbRateLbl.text = ""
        plotLbl.text = ""
        directorLbl.text = ""
        genreLbl.text = ""
        directorDefaultLbl.text = ""
        genreLbl.text = ""
        
        view.applyGradient(colors: [
            UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1),
            UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        ])
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
        directorDefaultLbl.text = "DIRECTOR"
        genreDefaultLbl.text = "GENRE"
        
        if let poster = movieDetail.poster, let url = URL(string: poster) {
            movieImgView.kf.setImage(with: url)
            movieOpaqueImgView.kf.setImage(with: url)
        } else {
            movieImgView.image = UIImage(named: "placeholder")
        }

        Analytics.logEvent("movie_detail_viewed", parameters: [
            "movie_title": movieDetail.title,
            "movie_imdb": movieDetail.imdbRating,
            "movie_actors": movieDetail.actors,
            "movie_country": movieDetail.country
        ])
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
    
    var transitioningImageView: UIImageView? {
            return movieImgView
        }
}
