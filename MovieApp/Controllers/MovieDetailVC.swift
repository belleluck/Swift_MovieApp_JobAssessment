//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import Cosmos

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgMainPoster: UIImageView!
    
    @IBOutlet weak var viewStarRating: CosmosView!
    
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblVotes: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPlotSummaryBody: UILabel!
    
    @IBOutlet weak var ratingTableView: UITableView!
    
    var selectedMovieID: String = ""
    var selectedMovieDetail: MovieDetail = MovieDetail()
    
    lazy var movieRatingItems: [MovieDetailRatingItem] = {
        let movieDetail = MovieDetailDB.instance.getMovieDetailByID(movieID: selectedMovieID)
        return movieDetail.otherRatingSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\n\nThe selected movie ID is: \(selectedMovieID)")
//        dump(selectedMovieDetail)
        print("the movieRatingItems is: ")
        dump(movieRatingItems)
        
        ratingTableView.dataSource = self
        ratingTableView.delegate = self
        ratingTableView.tableFooterView = UIView()
        ratingTableView.separatorStyle = .none
        
        title = "Movie Detail"
        
        selectedMovieDetail = MovieDetailDB.instance.getMovieDetailByID(movieID: selectedMovieID)
        
        initView()
    }

    func initView() {
        
        imgBackground.downloadedFrom(link: selectedMovieDetail.imgPosterURL)
        imgMainPoster.downloadedFrom(link: selectedMovieDetail.imgPosterURL)
        imgMainPoster.layer.cornerRadius = 20
        
        viewStarRating.rating = Double(selectedMovieDetail.imdbRating / 2)
        
        lblRating.text = "\(selectedMovieDetail.imdbRating) / 10"
        lblVotes.text = "\(selectedMovieDetail.imdbVotes) ratings"
        lblMovieTitle.text = "\(selectedMovieDetail.movieTitle) (\(selectedMovieDetail.movieYear)"
        
        lblGenre.text = "\(selectedMovieDetail.movieGenre)"
        lblPlotSummaryBody.text = selectedMovieDetail.moviePlot
        
    }

}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRatingTableViewCell") as! MovieRatingTableViewCell
            cell.movieRatingItemsData = movieRatingItems
            
            return cell
//        }
//
//        let cell = UITableViewCell()
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
            return CGFloat(150)
//        }
//        return CGFloat(10)
    }
}
