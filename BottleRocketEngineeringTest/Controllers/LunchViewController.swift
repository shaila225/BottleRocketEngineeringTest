import UIKit

class LunchViewController: UIViewController {

    private let flowLayout = UICollectionViewFlowLayout()
    private var resListViewModel = RestaurantsListViewModel(restaurantsList: .init())
    
    private var serviceAgent = RestaurantServiceAgent()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LunchCollectionViewCell.self, forCellWithReuseIdentifier: "lunchCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        layout()
        
        serviceAgent.fetch(forResource: .restaurants) { result in
            switch result {
            case .success(let model):
                self.resListViewModel = RestaurantsListViewModel(restaurantsList: model.restaurants)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func onTapMap() {
        let vc = MapViewController()
        vc.locations = resListViewModel.restaurantsList
        self.present(vc, animated: true)
    }
}

extension LunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resListViewModel.restaurantsList.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lunchCell", for: indexPath) as! LunchCollectionViewCell
        
        cell.backgroundColor = .gray
        let vm = self.resListViewModel.restaurantAtIndex(indexPath.row)
        
        cell.cateogoryLabel.text = vm.category
        cell.restaurantNameLabel.text = vm.name
        cell.imageView.fromAPI(imageURLString: vm.imageURL, defaultImage: "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width/1.0
           
           return CGSize(width: itemWidth, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailLunchViewController()
        
        vc.model = resListViewModel.restaurantsList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension LunchViewController {
    private func setup() {
        self.view.backgroundColor = .white
        title = "Lunch Tyme"
        
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            image: UIImage(named: "icon_map"),
            style: .plain, target: self,
            action: #selector(onTapMap)
        )
       
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
