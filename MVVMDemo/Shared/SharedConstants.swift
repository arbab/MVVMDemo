//
//  SharedConstants.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation

public enum AccessiblityIdentifiers {
    public enum HomeScreen {
        public static var searchTextField = "searchTextField"
        public static var searchButton = "searchButton"
    }
    
    public enum LoginScreen {
        public static var loginTextField = "loginTextField"
        public static var passwordTextField = "passwordTextField"
        public static var signInButton = "signInButton"
    }
}



final class AppState: ObservableObject {
    static var shared = AppState()

    @Published var isAuthorized: Bool

    private var authorizedKey = "authorized"
    
    init() {
        self.isAuthorized = UserDefaults.standard.bool(forKey: authorizedKey)
    }

    func set(authorized: Bool) {
        UserDefaults.standard.setValue(authorized, forKey: authorizedKey)
        isAuthorized = authorized
    }

}
