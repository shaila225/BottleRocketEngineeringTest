import Foundation

struct MasterRestaurantModel: Codable {
    let restaurants: [RestaurantModel]
}

// MARK: - RestaurantModel
struct RestaurantModel: Codable {
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location?
}

// MARK: - Contact
struct Contact: Codable {
    let phone: String
    let formattedPhone: String
    let twitter: String?
    
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
    
}
