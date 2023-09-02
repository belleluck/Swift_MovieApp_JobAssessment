//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import Alamofire
//import SWXMLHash

class MovieListVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var cellMarginSize = 16.0
    
    var arrMovies: [Movie] = [Movie]()
    var selectecdMovie: MovieDetail = MovieDetail()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Movie List"
        
        searchBar.delegate = self
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        movieCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        setupGridView()
        
        setupInitialMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.placeholder = "Search"
    }
    
    func setupGridView() {
        let flow = movieCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(cellMarginSize / 2)
        flow.minimumLineSpacing = CGFloat(cellMarginSize)
    }
    
    func setupInitialMovieData() {
        let movieList = MovieDB.instance.getAllMovie()
        if (movieList.count > 0) {
            arrMovies = movieList
            refreshCollection()
        }
    }
    
    func refreshCollection() {
        movieCollectionView.reloadData()
    }
    
    func fetchMovieListData() {
        
        guard let searchText = searchBar.text else {
            return
        }
        
        let appUrl: AppURL = AppURL()
        let url: String = appUrl.GetSearchedMovieList(searchText: searchText)
        
        let uploadManager: Session = Alamofire.Session()
        uploadManager.session.configuration.timeoutIntervalForResource = 2000
        uploadManager.request(url).responseJSON { [self] response in
            uploadManager.session.invalidateAndCancel()
            
//            switch (response.result) {
//                case .success(let value):
//
//                    if let json = value as? [String: Any] {
//                        print("got the json data")
//                        print(json)
//                    }
//
//                    print("\n\nSuccessfully grab value")
//                    print(value)
//                    break
//
//                case .failure(let error):
//                    print(error)
//            }
            
            switch (response.result) {
                case .success(let value):
                
                    if let json = value as? [String: Any] {
                        print("got the json data")
                        print(json)
                        
                        let jsonArray = json["Search"] as! [[String: Any]]
                        
                        MovieDB.instance.deleteMovie()
                        
                        for mItem in jsonArray {
                            let movie: Movie = Movie(
                                movieTitle: mItem["Title"] as? String ?? "",
                                movieType: mItem["Type"] as? String ?? "",
                                movieYear: mItem["Year"] as? Int ?? 0,
                                imdbID: mItem["imdbID"] as? String ?? "",
                                posterURL: mItem["Poster"] as? String ?? "",
                                posterData: ""
                            )
                            MovieDB.instance.addMovie(movie: movie)
                        }
                        print("download movie list successful")
                        
                        let movieList = MovieDB.instance.getAllMovie()
                        if (movieList.count > 0) {
                            arrMovies = movieList
                            refreshCollection()
                        }
                    }
                    else {
                        print("failed to download movie list")
                    }

                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchMovieDetailData(movieID: String, group: DispatchGroup) {
        group.enter()
        
        let appUrl: AppURL = AppURL()
        let url: String = appUrl.GetSingleMovieDetail(movieID: movieID)
        selectecdMovie = MovieDetail()
        
        let uploadManager: Session = Alamofire.Session()
        uploadManager.session.configuration.timeoutIntervalForResource = 2000
        uploadManager.request(url).responseJSON { [self] response in
            uploadManager.session.invalidateAndCancel()
            
            switch (response.result) {
                case .success(let value):
                
                    if let json = value as? [String: Any] {
                        print("got the json data")
                        print(json)
                        
                        MovieDetailDB.instance.deleteMovieDetail()
                        
                        var mDetailRatings: [MovieDetailRatingItem] = [MovieDetailRatingItem]()
                        var displayOrder: Int = 0
                        let mID = json["imdbID"] as? String ?? ""
                        let arrRatings = json["Ratings"] as? [[String: Any]] ?? [["": ""]]
                        
                        for mChild in arrRatings {
                            displayOrder += 1
                            mDetailRatings.append(
                                MovieDetailRatingItem(
                                    id: mID,
                                    displayOrder: displayOrder,
                                    ratingSource: mChild["Source"] as? String ?? "",
                                    ratingValue: mChild["Value"] as? String ?? ""
                                )
                            )
                        }
                        
                        selectecdMovie = MovieDetail(
                            id: mID,
                            movieTitle: json["Title"] as? String ?? "",
                            movieYear: Int(json["Year"] as? String ?? "0")!,
                            movieGenre: json["Genre"] as? String ?? "",
                            imdbRating: Float(json["imdbRating"] as? String ?? "0")!,
                            imdbVotes: json["imdbVotes"] as? String ?? "",
                            moviePlot: json["Plot"] as? String ?? "",
                            imgPosterURL: json["Poster"] as? String ?? "",
                            otherRatingSource: mDetailRatings
                        )
                        
                        // here can add into DB if needed
                        MovieDetailDB.instance.addMovieDetail(movieDetail: selectecdMovie)
                        print("download movie list successful")
                    }
                    else {
                        print("failed to download movie list")
                    }

                case .failure(let error):
                    print(error)
            }
            group.leave()
        }
        
    }

}

extension MovieListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchedText: String = searchText.lowercased()
        
        if (!(searchedText.isEmpty)) {
            
        }
        else {
            
        }
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).title = "Delete"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        print("Search bar search button clicked: \(String(describing: searchBar.text))")
        fetchMovieListData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of the MovieListCollectionViewCell")
        }
        cell.viewContainer.layer.cornerRadius = 15
        cell.viewContainer.layer.masksToBounds = true
        
        cell.imgPoster.downloadedMoviePosterFrom(link: arrMovies[indexPath.row].posterURL)
        cell.gradientOverlay.applyGradient(colours: [UIColor.clear, UIColor.black])
        
        cell.lblMovieName.text = arrMovies[indexPath.row].movieTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        let height = ((4 * width) / 3)
        return CGSize(width: width, height: height)
    }
    
    func calculateWidth() -> CGFloat {
        let totalScreenWidth = view.frame.width
//        print("totalScreenWidth: \(totalScreenWidth)")
        
        let estimateItemWidth = (totalScreenWidth - (16 * 3)) / 2
//        print("estimateItemWidth: \(estimateItemWidth)")
        
        let cellCount = floor(CGFloat(view.frame.size.width / estimateItemWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) /  cellCount
//        print("width: \(width)")
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\n\nCollection item clicked")
        print("item: \(indexPath.row)")
        print("item id: \(arrMovies[indexPath.row].imdbID)")
        
        ISGlobal.instance.displayLoadingScreen(vc: self)
        
        let group: DispatchGroup = DispatchGroup()
        fetchMovieDetailData(movieID: arrMovies[indexPath.row].imdbID, group: group)
        
        group.notify(queue: .main) { [self] in
            ISGlobal.instance.removeLoadingScreen()
            if (MovieDetailDB.instance.getCount() > 0) {
                let vc: MovieDetailVC = UIStoryboard.Movie.movieDetailVC() as! MovieDetailVC
                vc.selectedMovieID = arrMovies[indexPath.row].imdbID
        //        vc.selectedMovieDetail = mDetailData
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        
        
    }
}
