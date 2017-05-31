//
//  APIFile.swift
//  JSONGetAndPostSwift
//
//  Created by Anilkumar Achuthan unni on 09/05/17.
//  Copyright © 2017 Anilkumar Achuthan unni. All rights reserved.
//

import UIKit
typealias completionBlock = (_ resultDictionary: NSArray, _ error: Error?) -> Void
var parsedData = NSDictionary() as Any

class APIFile: NSObject {

    
    class func sendGetMethod(_ url: String, key: String, withCompletionHandler handler: @escaping completionBlock) {
        print("url \(url)")
        print("-------> key \(key)")
        let urlString = url
        let urls = URL(string: urlString)
        let mutAbleRequest = NSMutableURLRequest(url: urls!)
        //mutAbleRequest.setValue("6ed7c143a9fd49319a4b518a876ba8ca", forHTTPHeaderField:"Api-Key")
        URLSession.shared.dataTask(with:mutAbleRequest as URLRequest) { (data, response, error) in
            if error != nil
            {
            } else {
                
              //  var parsedData: NSDictionary = NSDictionary() as Any as! NSDictionary
                do {
                    
                    //parsedData = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                   parsedData = try JSONSerialization.jsonObject(with: data!, options: [])

                    print(parsedData)
                    
                    
                    handler(parsedData  as! NSArray, nil);
                    
                } catch let error as NSError {
                    print(error)
                }
                DispatchQueue.main.async {
                    print("yet?")
                    
                }
            }
            
            }.resume()
    }

    class func downloadData(fromServer baseURL: String, bodyData body: [AnyHashable: Any], method methodName: String, post string: String, withCompletionHandler handler: @escaping completionBlock) {
        let getFullServer: String = "\(baseURL)"
        //Pass the parameters and Set the URL
        let urlString = URL(string: getFullServer)
        let post: String = "\(string)"
        // Convert NSString to NSData format
        let postData: Data? = post.data(using: String.Encoding.ascii, allowLossyConversion: false)
        let postLength: String? = "\(UInt((postData?.count)!))"
        // Create the URL Request and set the neccesary parameters
        let request = NSMutableURLRequest()
        request.url = urlString
        request.httpMethod = methodName
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        print("\(request)")
        request.httpBody = postData
        URLSession.shared.dataTask(with:request as URLRequest) { (data, response, error) in
            if error != nil
            {
            } else {
                do {
                    
                    parsedData = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    print(parsedData)
                    
                    handler(parsedData as! NSArray, nil);
                    
                } catch let error as NSError {
                    print(error)
                }
                DispatchQueue.main.async {
                    print("yet?")
                    
                }
            }
            
            }.resume()
    }
}
