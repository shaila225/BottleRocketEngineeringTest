import UIKit

extension UILabel {
    func applyTitleFont() {
        self.font = Font.RestNameFont
        self.textColor = Color.titleColor
    }
    
    func applyCategoryFont() {
        self.font = Font.categoryFont
        self.textColor = Color.detailFontColor
    }
    
    func applyRestaurantDetailsFont() {
        self.font = Font.RestDetailsFont
        self.textColor = Color.detailFontColor
    }
}
