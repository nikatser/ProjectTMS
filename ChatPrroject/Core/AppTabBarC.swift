import UIKit

class AppTabBarC: UITabBarController {
    
    //MARK: --Properties
    
    lazy var controllers: [UIViewController] = [peopleVC,
                                                messagesVC,]
    
    var messagesVC: UIViewController = {
        var VC = MessagesVC()
        let tabBarItem = UITabBarItem()
        VC.tabBarItem = tabBarItem
        tabBarItem.image = UIImage(systemName: "message.fill")
        tabBarItem.title = "Messages"
        VC.update()
        return VC
    }()
    
    let peopleVC: UIViewController = {
        var VC = PeopleVC()
        let tabBarItem = UITabBarItem()
        VC.tabBarItem = tabBarItem
        tabBarItem.image = UIImage(systemName: "person.3.fill")
        tabBarItem.title = "People"
        VC.update()
        return VC
    }()
    
    var backButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.setBackgroundImage(UIImage(named: "back"), for: .normal)
        
        return button
    }()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        self.tabBar.tintColor = Constant.shared.mainColor
        self.viewControllers = controllers
    }
    
}
