import UIKit
import MapKit

class MapViewController: UIViewController {

    public var locations: [RestaurantModel]?
    
    private var window: UIWindow?
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: CGRect(x: 0, y: 106, width: self.view.frame.width, height: 180))
        map.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        
        return map
    }()
    
    private let regionRadiusValue: CLLocationDistance = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        layout()
        setup()
       
    }
    
    private func setup() {
        let annotations = locations?.compactMap{ res -> LocationMapAnnotation in
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(res.location?.lat ?? 0.0), longitude: CLLocationDegrees(res.location?.lng ?? 0.0))
            
            return LocationMapAnnotation(title: res.name, name: res.category, coordinate: coordinate)
        }
        DispatchQueue.main.async { [weak self] in
            _ = annotations?.compactMap{ a in
                self?.addAnnotation(ann: a)
            }
            
            self?.centerMap(lat: CLLocationDegrees(self?.locations?.first?.location?.lat ?? 0.0), long: CLLocationDegrees(self?.locations?.first?.location?.lng ?? 0.0))
        }
    }
    
    private func layout() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: 300))
        self.view.addSubview(self.mapView)
    }
}

extension MapViewController: MKMapViewDelegate {}

// Mark: Helpers
extension MapViewController {
    private func centerMap(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let location = CLLocation(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadiusValue, longitudinalMeters: regionRadiusValue)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func createAnnotation(on location: CLLocationCoordinate2D, title: String, name: String) -> MKAnnotation {
        return LocationMapAnnotation.init(title: title, name: name, coordinate: location)
    }
    
    private func addAnnotation(ann: MKAnnotation) {
        self.mapView.addAnnotation(ann)
    }
}
