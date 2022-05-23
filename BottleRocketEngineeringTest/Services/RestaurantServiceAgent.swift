import Foundation

class RestaurantServiceAgent {
    static let shared = RestaurantServiceAgent()
    
    public func fetch(forResource: Resources, completion: @escaping (Result<MasterRestaurantModel, Error>) -> Void) {
        let baseURL = URL(string: "https://s3.amazonaws.com/br-codingexams/restaurants.json")!
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONDecoder().decode(MasterRestaurantModel.self, from: data!)
                completion(.success(json))
            } catch {
                print(completion(.failure(error)))
            }
        }
        .resume()
    }
}

enum Resources: String {
    case restaurants
}
