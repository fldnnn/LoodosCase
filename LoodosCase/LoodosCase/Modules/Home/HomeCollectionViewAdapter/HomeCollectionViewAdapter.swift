//
//  HomeCollectionViewAdapter.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

protocol MovieCollectionViewAdapterDelegate: AnyObject {
    func loadMoreData()
    func didSelectItem(at index: Int, imageView: UIImageView)
}

class MovieCollectionViewAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var delegate: MovieCollectionViewAdapterDelegate?
    private var movies: [Movie] = []

    func updateData(_ movies: [Movie]) {
        self.movies = movies
    }

    func appendData(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }

    func getMovie(at index: Int) -> Movie? {
        guard index < movies.count else { return nil }
        return movies[index]
    }

    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == movies.count - 1 {
            // Son elemana geldiğimizde daha fazla veri yüklemeyi tetikliyoruz
            delegate?.loadMoreData()
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }

    // UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.didSelectItem(at: indexPath.row)
        
        
        
        if let movie = getMovie(at: indexPath.row),
           let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell, let imageView = cell.movieImgView {
            delegate?.didSelectItem(at: indexPath.row, imageView: imageView)
        }
    }

    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 300)
    }
}
