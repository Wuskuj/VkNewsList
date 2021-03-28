//
//  ViewController.swift
//  VkNewsList
//
//  Created by Philip Bratov on 22.03.2021.
//

import UIKit

protocol AuthServiceDelegate : class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceFailed()
}

class AuthViewController: UIViewController {

    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
    }

    @IBAction func authButtonAction(_ sender: Any) {
        self.authService.wakeUpSession()
    }
}

