import UIKit
import WebKit

class InternetsViewController: UITabBarController {
    
    lazy var rocketWebView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        
        return web
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
         navigationController?.navigationBar.prefersLargeTitles = true
        
        setup()
        layout()
    }
    
    private func setup() {
        setupNavButtons()
        setupBottleRocketWebView()
    }
  
    private func setupNavButtons() {
        let backButton = UIBarButtonItem.init(image: UIImage(named:"ic_webBack"), style: .plain, target: self, action: #selector(onTapBack))
        let reloadButton = UIBarButtonItem.init(image: UIImage(named:"ic_webRefresh"), style: .plain, target: self, action: #selector(onTapReload))
        let forwardButton = UIBarButtonItem.init(image: UIImage(named:"ic_webForward"), style: .plain, target: self, action: #selector(onTapForward))
        self.navigationItem.leftBarButtonItems = [backButton, reloadButton, forwardButton]
    }
    
    private func setupBottleRocketWebView() {
        guard let url = URL(string: "https://www.bottlerocketstudios.com") else { return }
        let myRequest = URLRequest(url: url)
        rocketWebView.load(myRequest)
    }
    
    private func layout() {
        self.view.addSubview(rocketWebView)
        NSLayoutConstraint.activate([
            self.rocketWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.rocketWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.rocketWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.rocketWebView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func onTapBack() {
        rocketWebView.goBack()
    }
    
    @objc func onTapReload() {
        rocketWebView.reload()
    }
    
    @objc func onTapForward() {
        rocketWebView.goForward()
    }
    
}
