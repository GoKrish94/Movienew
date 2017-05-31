//
//  cvcon_LoginViewController.swift
//  MovieMunch
//
//  Created by Anilkumar Achuthan unni on 17/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
@IBOutlet var UsernameText: UITextField!
@IBOutlet var PasswordText: UITextField!
var userArray = Array<Any>()
@IBOutlet var ViewScreen: UIView!
var costStr = NSString()


override func viewDidLoad() {
    super.viewDidLoad()
    UsernameText.backgroundColor = .clear
    UsernameText.attributedPlaceholder = NSAttributedString(string: "Username or Email",
                                                            attributes: [NSForegroundColorAttributeName: UIColor.white])
    PasswordText.backgroundColor = .clear
    PasswordText.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSForegroundColorAttributeName: UIColor.white])
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    // 4
    //        let image = UIImage(named: "Combined Shape")
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    imageView.image = image
    // 5
    navigationItem.titleView = imageView
    
    
    
}

@IBAction func login(_ sender: AnyObject) {
    
    APIFile.downloadData(fromServer:"http://192.168.0.17:3636/MyService.asmx/Login?" , bodyData:[:] , method: "POST", post:"Email=\(UsernameText.text! as String)&PassWord=\(PasswordText.text! as String)&login_type=1"as String, withCompletionHandler: {( resultDictionary: NSArray,  error: Error?) -> Void in
        
        print("success is \(resultDictionary)")
        
        
        
        DispatchQueue.main.async {
            
            
            
            if resultDictionary.count == 0{
                let alert = UIAlertController(title: "Login Failed",
                                              message: "UserName or PassWord  is Incorrect",
                                              preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.performSegue(withIdentifier:"pushToPay", sender: self)
            }
            
        }
    })
}
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
}

@IBAction func NewRegistration(_ sender: Any) {
    self.performSegue(withIdentifier: "SignUp", sender: self)
    
}
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "pushToPay" {
        if let object = segue.destination as? PaymentVController {
            object.costStr = costStr as NSString
            
        }
    }
}

}
