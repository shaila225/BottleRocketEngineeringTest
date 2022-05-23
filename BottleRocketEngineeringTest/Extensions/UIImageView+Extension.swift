import UIKit
import Foundation

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    public func fromAPI(imageURLString: String, defaultImage: String?) {
        if let defaultImage = defaultImage {
            self.image = UIImage(named: defaultImage)
        }
        if let cachedImage = imageCache.object(forKey: imageURLString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: NSURL(string: imageURLString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async{
                let image = UIImage(data: data!)
                self.image = image
            }
        }).resume()
    }
}

