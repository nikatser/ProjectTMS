import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var userDefault = UserDefaults.standard
    
    lazy var navigationController = UINavigationController(rootViewController: AppTabBarC())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        userDefault.setValue(false, forKey: "isLogin")
        var isLogin = userDefault.object(forKey: "isLogin") as? Bool
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        if isLogin == true {
            startApp()
        } else {
            startSlider()
        }
    }
    
    func startApp() {
        let mainViewController = navigationController
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
    
    func startSlider() {
        let mainViewController = SliderVC()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

