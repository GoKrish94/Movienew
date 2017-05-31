//
//  TheaterViewController.swift
//  MovieMunch
//
//  Created by Anilkumar Achuthan unni on 22/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class TheaterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate{
var locationManager = CLLocationManager()
var placeMark = MKPlacemark()
var cityIdArray = NSArray()
var cityNameArray = NSArray()
var theatreArray = NSArray()
var theatreNameArray = NSArray()
var theatreStatusArray = NSArray()
var theatreAddressArray = NSArray()
var theatreLatArray = NSArray()
var theatreLngArray = NSArray()

var arrayTheatreList = NSMutableArray()
var selectedIndex = NSInteger()

var statusString = NSString()
var latitude = Double()
var longitude = Double()
var arrayList = NSMutableArray()

@IBOutlet weak var headerLabel: UILabel!
@IBOutlet weak var zipcodeField: UITextField!
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var cityField: UITextField!
@IBOutlet weak var mapView: MKMapView!
override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(red:1.00, green:0.20, blue:0.20, alpha:1.0)
    
    cityField.layer.borderWidth = 2
    cityField.layer.borderColor = UIColor.red.cgColor
    zipcodeField.layer.borderWidth = 2
    zipcodeField.layer.borderColor = UIColor.red.cgColor
    navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.20, blue:0.20, alpha:1.0)
    
    DispatchQueue.main.async {
        self.locationManager.delegate = self;
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
    }
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    imageView.image = image
    navigationItem.titleView = imageView
    
       tableView.isHidden = true
    headerLabel.isHidden = true
    //mapView.isHidden = true
    
    
}

@IBAction func searchByzip(_ sender: Any) {
    APIFile.downloadData(fromServer:"http://192.168.0.17:3636/MyService.asmx/SelectCityByZipCode?" , bodyData:[:] , method: "POST", post:"ZipCode=\(zipcodeField.text! as String)"as String, withCompletionHandler: {(_ resultDictionary: NSArray, _ error: Error?) -> Void in
        
        print("success is \(resultDictionary)")
        self.theatreNameArray = (resultDictionary.value(forKeyPath: "TheatreName") as! NSArray)
        self.theatreStatusArray = (resultDictionary.value(forKeyPath: "Status") as! NSArray)
        self.theatreAddressArray = (resultDictionary.value(forKeyPath: "Address") as! NSArray)
        self.theatreLatArray = (resultDictionary.value(forKeyPath: "Latitude") as! NSArray)
        self.theatreLngArray = (resultDictionary.value(forKeyPath: "Longitude") as! NSArray)
        if self.theatreNameArray.count == 0{
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.headerLabel.isHidden = true
                
                let alertController = UIAlertController(title: "Oops!", message: "There are no Theatres listed in your location.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
            
        else{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.headerLabel.isHidden = false
            }
        }
    })
}
func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
{
    let currentLocation = userLocation
    print(currentLocation.coordinate.latitude)
    print(currentLocation.coordinate.longitude)
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        // Place details
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]
        
        // Address dictionary
        print(placeMark.addressDictionary as Any)
        
        let city = placeMark.addressDictionary!["City"] as? NSString
        print(city as Any as! String)
        
        APIFile.downloadData(fromServer:"http://192.168.0.17:3636/MyService.asmx/SelectTheatreByCityName?" , bodyData:[:] , method: "POST", post:"CityName=\(city! as String)"as String, withCompletionHandler: {(_ resultDictionary: NSArray, _ error: Error?) -> Void in
            
            print("success is \(resultDictionary)")
            self.theatreNameArray = (resultDictionary.value(forKeyPath: "TheatreName") as! NSArray)
            self.theatreStatusArray = (resultDictionary.value(forKeyPath: "Status") as! NSArray)
            self.theatreAddressArray = (resultDictionary.value(forKeyPath: "Address") as! NSArray)
            self.theatreLatArray = (resultDictionary.value(forKeyPath: "Latitude") as! NSArray)
            self.theatreLngArray = (resultDictionary.value(forKeyPath: "Longitude") as! NSArray)
            
            if self.theatreNameArray.count == 0{
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                    self.headerLabel.isHidden = true
                    
                    let alertController = UIAlertController(title: "Oops!", message: "There are no Theatres listed in your location.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
                
            else{
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
        })
        
        
        
    })
    
    
    // print(placeMark.locality)
}


    @IBAction func CityandStateOutlet(_ sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
        
        
        let string: String = cityField.text!
        if string.contains(",") {
            var foo: [Any] = cityField.text!.components(separatedBy: ",")
            let cityString: String? = (foo[0] as? String)
            let stateString: String? = (foo[1] as? String)
            
            print("\(cityString)")
            print("\(stateString)")
            
            
            if(stateString == ""){
                let alertController = UIAlertController(title: "WARNING", message: "Please enter the State & City in this format ( Cityname,StateName ) to continue the Search ", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)

            }
            else{
                
                APIFile.downloadData(fromServer:"http://192.168.0.17:3636/MyService.asmx/SelectTheatreByCityNameandState?" , bodyData:[:] , method: "POST", post:"CityName=\(cityString! as String)&State=\(stateString! as String)"as String, withCompletionHandler: {( resultDictionary: NSArray,  error: Error?) -> Void in
                    
                    print("success is \(resultDictionary)")
                    self.theatreNameArray = (resultDictionary.value(forKeyPath: "TheatreName") as! NSArray)
                    self.theatreStatusArray = (resultDictionary.value(forKeyPath: "Status") as! NSArray)
                    self.theatreAddressArray = (resultDictionary.value(forKeyPath: "Address") as! NSArray)
                    self.theatreLatArray = (resultDictionary.value(forKeyPath: "Latitude") as! NSArray)
                    self.theatreLngArray = (resultDictionary.value(forKeyPath: "Longitude") as! NSArray)
                    
                    if self.theatreNameArray.count == 0{
                        DispatchQueue.main.async {
                            self.tableView.isHidden = true
                            self.headerLabel.isHidden = true
                            
                            let alertController = UIAlertController(title: "Oops!", message: "There are no Theatres listed in your location", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                        
                    else{
                        DispatchQueue.main.async {
                            self.tableView.isHidden = false
                            self.headerLabel.isHidden = false
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }else{
            let alertController = UIAlertController(title: "WARNING", message: "Please enter the State & City in this format ( Cityname,StateName ) to continue the Search ", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }

        
    }
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let annotationIdentifier = "SomeCustomIdentifier"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
    if annotationView == nil {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        annotationView?.canShowCallout = true
        
        // Resize image
        let pinImage = UIImage(named: "marker.png")
        let size = CGSize(width: 25, height: 40)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect (x:0,y: 0,width: size.width,height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        annotationView?.image = resizedImage
        let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
        annotationView?.rightCalloutAccessoryView = rightButton as? UIView
    }
    else {
        annotationView?.annotation = annotation
    }
    return annotationView!
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return theatreNameArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier: String = "TheatreCell"
    let cell: TheatreTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TheatreTableViewCell
    
    cell?.accessoryType = .disclosureIndicator
    
    cell?.nameLabel.text = theatreNameArray.object(at: indexPath.row) as? String
    cell?.addressLabel.text = theatreAddressArray.object(at: indexPath.row) as? String
    self.statusString = (theatreStatusArray.object(at: indexPath.row) as? String)! as NSString
    if self.statusString.isEqual("Yes"){
        cell?.backgroundColor = UIColor.red
    }else{
        cell?.backgroundColor = UIColor.white
        
    }
    
    self.latitude = (theatreLatArray.object(at: indexPath.row) as? Double)!
    self.longitude = (theatreLngArray.object(at: indexPath.row) as? Double)!
    var location = CLLocationCoordinate2D()
    location.latitude = self.latitude
    location.longitude = self.longitude
    
    let span = MKCoordinateSpanMake(0.1, 0.2) //Get current span?
    let region = MKCoordinateRegion(center: location, span: span)
    let point = MKPointAnnotation()
    point.coordinate = location
    point.title = theatreNameArray.object(at: indexPath.row) as? String
    point.subtitle = theatreAddressArray.object(at: indexPath.row) as? String
    mapView.addAnnotation(point)
    
    mapView.setRegion(region, animated: true)
    
    return cell!
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    self.statusString = (theatreStatusArray.object(at: indexPath.row) as? String)! as NSString
    if self.statusString.isEqual("Yes"){
        self.performSegue(withIdentifier: "pushToMovie", sender: self)
    }else{
        let alertController = UIAlertController(title: "Oops!", message: "This Theatre do not have MOVIE MUNCH option", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == cityField{
        tableView.isHidden = true
        headerLabel.isHidden = true
        
    }
}




override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "pushToMovie" {
        if let object = segue.destination as? vc_Movies {
            
            object.theatreName = self.theatreNameArray.object(at: selectedIndex) as! String as NSString
            object.theatreAddress = self.theatreAddressArray.object(at: selectedIndex) as! String as NSString
            
        }
    }
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
