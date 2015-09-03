//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Bao Pham on 8/31/15.
//  Copyright © 2015 Bao Pham. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var descDetails: UILabel!
    @IBOutlet weak var crisisScore: UILabel!
    @IBOutlet weak var audienceScrore: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    
    var movie:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        titleDetail.text = (movie["title"]) as! String
        descDetails.text = (movie["synopsis"]) as! String
        //let crisis = NSURL(string: movie.valueForKeyPath("ratings.critics_score") as! Int)
        //crisisScore.text = (movie.valueForKeyPath("ratings.critics_score") as! String)
        let critics = (movie.valueForKeyPath("ratings.critics_score") as! Int)
        crisisScore.text = "Critics Score: " + String(critics)
        let audience = (movie.valueForKeyPath("ratings.audience_score") as! Int)
        audienceScrore.text = "Audience Score: " + String(audience)
        
        
        let url_temp = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        
        var url_posterOri:String = String(url_temp)
        
        var range = url_posterOri.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url_posterOri = url_posterOri.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        let url_poster = NSURL(string: url_posterOri)
            
        posterView.setImageWithURL(url_poster!)
        

        
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
