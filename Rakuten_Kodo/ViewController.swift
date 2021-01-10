//
//  ViewController.swift
//  Rakuten_Kodo
//
//  Created by John Fowler on 1/10/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var yearInput: UITextField!
    @IBOutlet var latInput: UITextField!
    @IBOutlet var lngInput: UITextField!
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var data = LaureateLoader().laureateData
    var userYear = "0"
    var userLat = "0"
    var userLng = "0"
    
    @IBAction func updateTapped() {
        errorLabel.isHidden = true
         if (yearInput.text != "" && userYear != yearInput.text) {
            if (1900 > Int(yearInput.text!)! || Int(yearInput.text!)! > 2020) {
                errorLabel.text = "Year can only be between 1900 - 2020"
                errorLabel.isHidden = false
                return
            } else {
                userYear = yearInput.text!
            }
        }
        if (latInput.text != "" && userLat != latInput.text) {
            if (Int(latInput.text!)! > -90 && Int(latInput.text!)! < 90) {
                userLat = latInput.text!
            } else {
                errorLabel.text = "Latitude has to be between -90 and 90"
                errorLabel.isHidden = false
                return
            }
        }
        if (lngInput.text != "" && userLng != lngInput.text) {
            if (Int(lngInput.text!)! > -180 && Int(lngInput.text!)! < 180) {
                userLng = lngInput.text!
            } else {
                errorLabel.text = "Longitude has to be between -180 and 180"
                errorLabel.isHidden = false
                return
            }
        }
        
        sortLaureate()
        dismissKeyboard()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "LaureateTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LaureateTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func sortLaureate() {
        data = data.sorted(by: {
            let year0 = abs(Int($0.year)! - Int(userYear)!)
            let year1 = abs(Int($1.year)! - Int(userYear)!)
            
            if (year0 == year1) {
                let base = CLLocation(latitude: Double(userLat)!, longitude: Double(userLng)!)
                let coordinate0 = CLLocation(latitude: $0.location.lat, longitude: $0.location.lng)
                let coordinate1 = CLLocation(latitude: $1.location.lat, longitude: $1.location.lng)

                let distance1 = base.distance(from: coordinate0)
                let distance2 = base.distance(from: coordinate1)
                return distance1 < distance2
            } else {
                return year0 < year1
            }
        })
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaureateTableViewCell", for: indexPath) as! LaureateTableViewCell
        
        cell.name?.text = data[indexPath.row].firstname + " " + data[indexPath.row].surname
        cell.locationName?.text = data[indexPath.row].name
        cell.year?.text = data[indexPath.row].year
        cell.lat?.text = "Lat: " + String(data[indexPath.row].location.lat)
        cell.lng?.text = "Lng: " + String(data[indexPath.row].location.lng)
        
        return cell
    }
}
