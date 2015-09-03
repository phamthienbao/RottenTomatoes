//
//  NetworkChecking.swift
//  RottenTomatoes
//
//  Created by Bao Pham on 8/31/15.
//  Copyright © 2015 Bao Pham. All rights reserved.
//

import Foundation
public class Reachability {
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url1 = NSURL(string: "http://google.com/")
        let request1 = NSMutableURLRequest(URL: url1!)
        request1.HTTPMethod = "HEAD"
        request1.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request1.timeoutInterval = 10.0
        
        var response1: NSURLResponse? = nil
        var error1: NSError? = nil
        NSURLConnection.sendAsynchronousRequest(request1, queue: NSOperationQueue.mainQueue()) { (response1: NSURLResponse?, data1: NSData?, error1: NSError?) -> Void in
            
        if let httpResponse = response1 as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            } else {
                Status = false
            }
            }
        }
        
        return Status
    }
}