import UIKit

class TabBarController: UITabBarController {
    
    lazy var lunchNavigationBarAppearance: UINavigationBarAppearance = {
        let nav = UINavigationBarAppearance()
        nav.configureWithOpaqueBackground()
        nav.backgroundColor = Color.navBarColor
        
        return nav
    }()
    
    lazy var tabBarAppearance: UITabBarAppearance = {
        let tab = UITabBarAppearance()
        tab.configureWithOpaqueBackground()
        tab.backgroundColor = Color.tabBarColor
        
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        addViewControllers()
        setupTabBarUI()
    }
}


// Mark:- UI Setup
extension TabBarController {
    private func addViewControllers() {
        let vc = UINavigationController(rootViewController: LunchViewController())
        vc.navigationBar.standardAppearance = lunchNavigationBarAppearance
        vc.navigationBar.scrollEdgeAppearance = lunchNavigationBarAppearance
        vc.navigationBar.tintColor = .white
        vc.tabBarItem = UITabBarItem(title: "lunch", image: UIImage(named: "tab_lunch"), tag: 0)
        
        let vc2 = UINavigationController(rootViewController: InternetsViewController())
        vc2.tabBarItem = UITabBarItem(title: "internets", image: UIImage(named: "tab_internets"), tag: 1)
        vc2.navigationBar.standardAppearance = lunchNavigationBarAppearance
        vc2.navigationBar.scrollEdgeAppearance = lunchNavigationBarAppearance
        vc2.navigationBar.tintColor = .white
        
        viewControllers = [vc, vc2]
    }
    
    private func setupTabBarUI() {
        self.tabBar.barTintColor = Color.tabBarColor
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        self.tabBar.tintColor = .white
    }
}
