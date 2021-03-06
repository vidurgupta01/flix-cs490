//
//  ViewController.swift
//  Flix
//
//  Created by Vidur Gupta on 1/22/20.
//  Copyright © 2020 Vidur Gupta. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var movies = [[String:Any]]()
    let refreshCtrl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Movies"
        
        tableview.delegate = self
        tableview.dataSource = self
        
        refreshCtrl.addTarget(self, action: #selector(fetchMovieData), for: .valueChanged)
        
        tableview.addSubview(refreshCtrl)
        
        
        fetchMovieData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        
        let movie = movies[indexPath.row]
        
        cell.lblTitle.text = movie["title"] as? String
        cell.lblSynopsis.text = movie["overview"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        cell.imgPoster.af_setImage(withURL: posterURL!)
        
        return cell
    }
    
    @objc func fetchMovieData() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String:Any]]

            self.tableview.reloadData()
            self.refreshCtrl.endRefreshing()

           }
        }
        task.resume()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading detail screen...")
        
        let cell = sender as! UITableViewCell
        let indexPath = tableview.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsVC = segue.destination as! MovieDetailViewController
        detailsVC.movie = movie
    }
    
    

}
