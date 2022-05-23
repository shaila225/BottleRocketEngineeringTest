import UIKit
import MapKit

class LocationMapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let name: String
    
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String? {
        return name
    }
    
    init(title: String, name: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.name = name
        self.coordinate = coordinate
        
        super.init()
    }
}
