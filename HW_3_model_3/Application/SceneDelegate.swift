//
//  SceneDelegate.swift
//  HW_3_model_3
//
//  Created by Nikita Shipovskiy on 09/06/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appModel = AppModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        NotificationCenter.default.addObserver(self, selector: #selector(setRoot(nt: )), name: NSNotification.Name("setRoot"), object: nil)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        if appModel.isUserLogin() {
            self.window?.rootViewController = TabBarViewController()
        }else {
            self.window?.rootViewController = RegistrationViewController()
        }
        self.window?.makeKeyAndVisible()
    }
    
    @objc func setRoot(nt: Notification) {
        guard let vc = nt.userInfo?["vc"] as? String else {return}
        
        switch vc {
        case "login":
            self.window?.rootViewController = LoginViewController()
        case "tabBar":
            self.window?.rootViewController = TabBarViewController()
        case "forget":
            self.window?.rootViewController = ForgetPasswordViewController()
        default:
            self.window?.rootViewController = RegistrationViewController()
        }
     }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

