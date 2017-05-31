//
//  RegisterVIewController.swift
//  MovieMunch
//
//  Created by Anil Kumar on 17/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Accounts

class RegisterVIewController: UIViewController,FBSDKLoginButtonDelegate {
var fbsdkToken = String() as Any
var userArray = NSDictionary()

@IBOutlet var Email: UITextField!
@IBOutlet var Username: UITextField!

@IBOutlet var Password: UITextField!
@IBOutlet var Mobile: UITextField!
override func viewDidLoad() {
    super.viewDidLoad()
    let loginButton = FBSDKLoginButton()
    let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
    loginButton.center = newCenter
    view.addSubview(loginButton)
    loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    loginButton.delegate = self
    
    let logInButton = TWTRLogInButton { (session, error) in
        print(" \(session)")
        if let unwrappedSession = session {
            
            let alert = UIAlertController(title: "Logged In",
                                          message: "User \(unwrappedSession.userName) has logged in",
                preferredStyle: UIAlertControllerStyle.alert
            )
            self.Username.text = unwrappedSession.userName
            self.Email.text =  "\(unwrappedSession.userName)@gmail.com"
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            NSLog("Login error: %@", error!.localizedDescription);
        }
    }
    
    
    
    // TODO: Change where the log in button is positioned in your view
    
    let button = logInButton
    let NewCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 120)
    
    button.center = NewCenter
    self.view.addSubview(button)
    
    
    Email.backgroundColor = .clear
    Email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                     attributes: [NSForegroundColorAttributeName: UIColor.white])
    Username.backgroundColor = .clear
    Username.attributedPlaceholder = NSAttributedString(string: "Username",
                                                        attributes: [NSForegroundColorAttributeName: UIColor.white])
    
    
    Mobile.backgroundColor = .clear
    Mobile.attributedPlaceholder = NSAttributedString(string: "Mobile",
                                                      attributes: [NSForegroundColorAttributeName: UIColor.white])
    
    Password.backgroundColor = .clear
    Password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                        attributes: [NSForegroundColorAttributeName: UIColor.white])
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


@IBAction func SignUp(_ sender: AnyObject) {
    APIFile.downloadData(fromServer:"http://192.168.0.14:3636/MyService.asmx/Register?" , bodyData:[:] , method: "POST", post:"Email=\(Email.text! as String)&Name=\(Username.text! as String)&PassWord=\(Password.text! as String)&Mobile=\(Mobile.text! as String)&login_type=1"as String, withCompletionHandler: {( resultDictionary: NSArray,  error: Error?) -> Void in
        
        print("success is \(resultDictionary)")
        DispatchQueue.main.async {
            
            if resultDictionary.count == 0{
                let alert = UIAlertController(title: "Registration Failed",
                                              message: "Please give the valid Values",
                                              preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
                let alert = UIAlertController(title: "Success",
                                              message: "Registered Successfully",
                                              preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.Email.text = ""
                self.Username.text = ""
                self.Password.text = ""
                self.Mobile.text = ""
                
            }}
        
        
    })
}

func getFBUserDetails() {
    //if(self.fbsdkToken){
    var parameters = [AnyHashable: Any]()
    parameters["fields"] = "id,name,email,first_name,last_name,middle_name,birthday"
    FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {( connection,  result, error)  in
        
        
        if (result != nil) {
            //  let facebookId: String? = (result as AnyObject).value(forKey:"id")
            // let imageUrl: String = "http://graph.facebook.com/\(facebookId)/picture?type=large"
            //   _profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
            print("image ur lsi \(result)")
            self.userArray = result as! NSDictionary
            
            
            print("\(self.userArray.value(forKey: "Name"))")
            self.Email.text = self.userArray.value(forKey: "email") as! String?
            self.Username.text = self.userArray.value(forKey: "name") as! String?
            
            
            
        }
    })
}

func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    print("User Logged Out")
}

func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    print("User Logged In")
    
    getFBUserDetails()
    
    
}





override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
