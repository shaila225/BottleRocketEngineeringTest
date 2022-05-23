import UIKit
import MapKit

class DetailLunchViewController: UIViewController {
    var model: RestaurantModel? = nil
    
    var window: UIWindow?
    lazy var mapView: MKMapView = {
        let map = MKMapView(frame: CGRect(x: 0, y: 106, width: self.view.frame.width, height:180))
        map.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        
        return map
    }()
    
    lazy var blockView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    private let regionRadiusValue: CLLocationDistance = 1500
    
    lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyRestaurantDetailsFont()
        
        return label
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyCategoryFont()
        
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        layout()
        setup()
       
    }
    
    private func setup() {
        self.view.backgroundColor = .white
        if let lat = CLLocationDegrees(exactly: self.model?.location?.lat ?? 0.0),
           let long = CLLocationDegrees(exactly: self.model?.location?.lng ?? 0.0) {
            
            centerMap(lat: lat, long: long)

            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = self.createAnnotation(on:  location, title: self.model?.name ?? "", name: self.model?.category ?? "")
             
             self.addAnnotation(annotation)
            
            categoryLabel.text = self.model?.category
            restaurantLabel.text = self.model?.name
        }
    }
    
    private func layout() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: 300))
        self.view.addSubview(self.mapView)
         
        
        self.mapView.addSubview(blockView)
        self.blockView.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor).isActive = true
        self.blockView.leadingAnchor.constraint(equalTo: self.mapView.leadingAnchor).isActive = true
        self.blockView.trailingAnchor.constraint(equalTo: self.mapView.trailingAnchor).isActive = true
        
        
        self.view.addSubview(restaurantLabel)
        restaurantLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16).isActive = true
        restaurantLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor).isActive = true
          
        self.view.addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: restaurantLabel.bottomAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor).isActive = true
    }
}

extension DetailLunchViewController: MKMapViewDelegate {}


// Mark: Helpers
extension DetailLunchViewController {
    private func centerMap(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let location = CLLocation(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadiusValue, longitudinalMeters: regionRadiusValue)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func createAnnotation(on location: CLLocationCoordinate2D, title: String, name: String) -> MKAnnotation {
        return LocationMapAnnotation.init(title: title, name: name, coordinate: location)
    }
    
    private func addAnnotation(_ ann: MKAnnotation) {
        self.mapView.addAnnotation(ann)
    }
}
