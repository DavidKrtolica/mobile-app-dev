//
//  ViewController.swift
//  MapDemo
//
//  Created by user192371 on 3/15/21.
//

import UIKit
import MapKit
import Firebase

//let fS = FirebaseService()

class ViewController: UIViewController, Updateable {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var addTitle: UITextField!
    private var db = Firestore.firestore()
    var locations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startListener()
        //ADDING A PIZZERIA LOCATION AS MAP ANNOTATION
        let bestPizza = MKPointAnnotation()
        bestPizza.title = "Best pizzeria"
        bestPizza.coordinate = CLLocationCoordinate2D(latitude: 55.71169030000001,longitude: 12.593819199999999)
        map.addAnnotation(bestPizza)
    }
    
    func update() {
        map.reloadInputViews()
    }
    
    //READING AL LOCATIONS FROM FIREBASE
    func startListener() {
        db.collection("locations").addSnapshotListener { (snap, error) in
            if let e = error {
                print("error fetching data \(e)")
            } else {
                if let s = snap {
                    self.locations.removeAll()
                    for doc in s.documents {
                        if let txt = doc.data()["title"] as? String, let coor = doc.data()["coordinates"] as? GeoPoint {
                            print(txt)
                            print(coor)
                            print(doc.documentID)
                            let ann = MKPointAnnotation()
                            ann.title = txt
                            ann.coordinate = CLLocationCoordinate2D(latitude: coor.latitude, longitude: coor.longitude)
                            self.locations.append(ann)
                            self.map.addAnnotations(self.locations)
                        }
                    }
                    
                }
            }
        }
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let cgPoint = sender.location(in: map) //GETS COORDINATES
            let coordinate2D = map.convert(cgPoint, toCoordinateFrom: map)
            //print(cgPoint.debugDescription)
            print("\(coordinate2D.latitude), \(coordinate2D.longitude)")
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate2D
            if let txt = addTitle.text {
                anno.title = txt
                addTitle.text = ""
            }
            map.addAnnotation(anno)
            //SAVING TO FIREBASE
            let doc = db.collection("locations").document()
            var data = [String:Any]()
            data["title"] = anno.title
            data["coordinates"] = GeoPoint(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
            doc.setData(data)
        }
    }
    
}
