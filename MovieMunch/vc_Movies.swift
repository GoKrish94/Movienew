//
//  vc_Movies.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/24/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class vc_Movies: UIViewController {

var theatreName = NSString()
var theatreAddress = NSString()


@IBOutlet weak var addressLabel: UILabel!
@IBOutlet var movieLable: UILabel!
override func viewDidLoad() {
    super.viewDidLoad()
    movieLable.text = self.theatreName as String
    self.addressLabel.text = self.theatreAddress as String
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    // 4
    //        let image = UIImage(named: "Combined Shape")
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    imageView.image = image
    // 5
    navigationItem.titleView = imageView
    // Do any additional setup after loading the view.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "pushToTimes" {
        if let object = segue.destination as? ViewController {
            
            object.theatreName = self.theatreName as String  as NSString
            object.theatreAddress = self.theatreAddress as String as NSString
        }
    }
}
}
