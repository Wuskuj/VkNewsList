//
//  AuthService.swift
//  VkNewsList
//
//  Created by Philip Bratov on 23.03.2021.
//

import Foundation
import VK_ios_sdk

class AuthService : NSObject {
    private let appId = "7799278"
    private let vkSdk: VKSdk?

    weak var delegate: AuthServiceDelegate?

    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }

    override init() {
        self.vkSdk = VKSdk.initialize(withAppId: self.appId)
        super.init()
        print("VkSdk initialize")
        vkSdk?.uiDelegate = self
        vkSdk?.register(self)
    }

    func wakeUpSession() {
        let scoup = ["wall", "friends"]
        VKSdk.wakeUpSession(scoup) { [delegate] (state, error) in
            if let error = error {
                print(error)
                return
            }

            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scoup)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceFailed()
            }
        }
    }
}

extension AuthService : VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil  {
            self.delegate?.authServiceSignIn()
        }
    }

    func vkSdkUserAuthorizationFailed() {
        self.delegate?.authServiceFailed()
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.delegate?.authServiceShouldShow(viewController: controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }

}
