import Foundation
import UIKit

public struct RestaurantsListViewModel {
     let restaurantsList: [RestaurantModel]
    
    public var numberOfsection: Int {
        return 1
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return 15
    }
    
    func restaurantAtIndex(_ index: Int) -> RestaurantViewModel {
        let restaurant = self.restaurantsList[index]
        
        return RestaurantViewModel(restaurant)
    }
    
}


struct RestaurantViewModel {
    private let restaurant: RestaurantModel
    
    init(_ restaurant: RestaurantModel) {
        self.restaurant = restaurant
    }
    
    var name: String {
        return restaurant.name
    }
    
    var category: String {
        return restaurant.category
    }
    
    var imageURL: String {
        return restaurant.backgroundImageURL
    }
    
}
