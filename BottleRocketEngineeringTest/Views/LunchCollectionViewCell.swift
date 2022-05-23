import UIKit

class LunchCollectionViewCell: UICollectionViewCell {
 
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var cateogoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
      
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }
    
    private func setup() {
        applyGradientToImageView()
    }
    
    private func applyGradientToImageView() {
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]

        imageView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func layout() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(cateogoryLabel)
        NSLayoutConstraint.activate([
            cateogoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cateogoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cateogoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        self.addSubview(restaurantNameLabel)
        NSLayoutConstraint.activate([
            restaurantNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            restaurantNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            restaurantNameLabel.bottomAnchor.constraint(equalTo: self.cateogoryLabel.bottomAnchor, constant: -16)
        ])
        
    }
}
