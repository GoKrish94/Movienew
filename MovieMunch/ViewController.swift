//
//  ViewController.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var theatreName = NSString()
    var theatreAddress = NSString()
    @IBOutlet weak var theatreLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theatreLabel.text = self.theatreName as String
        self.addressLabel.text = self.theatreAddress as String
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

