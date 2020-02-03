//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Vidur Gupta on 2/2/20.
//  Copyright © 2020 Vidur Gupta. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    var movie = [String:Any]()

    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgPosterView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSynopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.text = movie["title"] as? String
        self.lblTitle.sizeToFit()
        
        self.lblSynopsis.text = movie["overview"] as? String
        self.lblSynopsis.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        self.imgPosterView.af_setImage(withURL: posterURL!)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backDropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)
        
        self.imgBackdrop.af_setImage(withURL: backDropURL!)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
