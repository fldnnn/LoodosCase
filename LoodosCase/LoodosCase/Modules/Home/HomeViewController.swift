//
//  HomeViewController.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit
import Lottie

class HomeViewController: UIViewController, HomeViewProtocol, ImageTransitionable {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var animationContainerView: UIView!
    
    var presenter: HomePresenterProtocol?
    var animationView: LottieAnimationView?
    
    private var adapter: MovieCollectionViewAdapter!
    var transitioningImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewDidLoad()
    }
    
    func updateMovies(_ movies: [Movie]) {
        adapter.updateData(movies)
        reloadData()
    }
    
    func appendMovies(_ movies: [Movie]) {
        adapter.appendData(movies)
        reloadData()
    }
    
    func reloadData() {
        movieCollectionView.reloadData()
        movieCollectionView.refreshControl?.endRefreshing()
    }
    
    private func setupUI() {
        movieSearchBar.delegate = self
        // Search icon color
        movieSearchBar.searchTextField.leftView?.tintColor = .darkGray
        // Search background color
        movieSearchBar.searchTextField.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.white
        }
        // Search text color
        movieSearchBar.searchTextField.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.black
        }
        // Placeholder color
        movieSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search a movie",
            attributes: [.foregroundColor: UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor.darkGray
            }]
        )
        movieSearchBar.setImage(UIImage(systemName: "clear")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .clear, state: .normal)
        
        adapter = MovieCollectionViewAdapter()
        adapter.delegate = self
        
        movieCollectionView.delegate = adapter
        movieCollectionView.dataSource = adapter

        let cellNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        movieCollectionView.refreshControl = refreshControl
        
        navigationItem.hidesBackButton = true
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 30) / 2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        movieCollectionView.collectionViewLayout = design
        
        view.applyGradient(colors: [
            UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1),
            UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        ])
    }
    
    @objc private func refreshMovies() {
        presenter?.refreshMovies()
    }
    
    func showError(_ message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func showNoResultsMessage(_ message: String) {
        showAlert(title: "No results found.", message: message)
    }
    
    func showLoading() {
        animationView = .init(name: "loading")
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        if let animationView = animationView {
            animationContainerView.addSubview(animationView)
            animationView.play()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.animationView?.stop()
            self.animationView?.removeFromSuperview()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearchBar.showsCancelButton = true
        movieSearchBar.resignFirstResponder()
        if let query = searchBar.text, !query.isEmpty {
            presenter?.searchMovies(with: query)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        movieSearchBar.showsCancelButton = false
    }
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //    }
}

extension HomeViewController: MovieCollectionViewAdapterDelegate {
    func loadMoreData() {
        presenter?.loadMoreMovies()
    }
    
    func didSelectItem(at index: Int, imageView: UIImageView) {
        transitioningImageView = imageView
        if let movie = adapter.getMovie(at: index) {
            presenter?.didSelectMovie(movie, fromImageView: imageView)
        }
    }
}
