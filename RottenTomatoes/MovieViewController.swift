//
//  MovieViewController.swift
//  RottenTomatoes
//
//  Created by Bao Pham on 8/29/15.
//  Copyright © 2015 Bao Pham. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking
import BDBOAuth1Manager


 s

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var networkError: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    let refreshControl = UIRefreshControl()


    func onRefresh() {
        
        

        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let request = NSURLRequest(URL: url)
        
        SwiftLoader.show(title: "Loading data...", animated: true)
        
        if connectedToNetwork() == true {
            
            self.networkError.text = ""
            self.networkError.hidden = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in

            
            let json = try!NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print(json)

            
            if json == json {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
                SwiftLoader.hide()
                self.refreshControl.endRefreshing()
            }
            }

        
            self.tableView.dataSource = self
            self.tableView.delegate = self
     
        } else {
            self.tableView.reloadData()

            self.tableView.dataSource = self
            self.tableView.delegate = self

            self.refreshControl.endRefreshing()
            self.networkError.text = "Network Error"

            SwiftLoader.hide()
            
            self.networkError.sizeToFit()
            self.networkError.hidden = false
            
   
    }

    
    }


    //Check connection
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        return (isReachable && !needsConnection)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        
            refreshControl.addTarget(self, action: Selector("onRefresh"), forControlEvents: UIControlEvents.ValueChanged)
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            //tableview is your UITAbleView in UIViewController
            self.tableView.addSubview(refreshControl)
            
            self.networkError.text = ""
            self.networkError.hidden = true
            self.onRefresh()
            


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let movies_cells = tableView.dequeueReusableCellWithIdentifier("MoviesCell", forIndexPath: indexPath) as! MoviesCell
        
            let movie = movies![indexPath.row]
            
            if connectedToNetwork() == true {

            movies_cells.titleMovie?.text = (movie["title"] as! String)
            movies_cells.descMovie?.text =  (movie["synopsis"] as! String)
            
            
            let url_thumb = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!

            movies_cells.posterThumb.setImageWithURL(url_thumb)
            } else {
                movies_cells.titleMovie?.text = ""
                movies_cells.descMovie?.text =  ""
                movies_cells.posterThumb.image = nil

                
            }
                
                
            return movies_cells
            
        }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let index_path = tableView.indexPathForCell(cell)
        let movie = movies![index_path!.row]
    
        let movieDetailsController = segue.destinationViewController as! MovieDetailsViewController
        
        movieDetailsController.movie = movie
        
        
        
    }
    

}
