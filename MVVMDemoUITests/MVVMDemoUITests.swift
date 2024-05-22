//
//  MVVMDemoUITests.swift
//  MVVMDemoUITests
//
//  Created by Arbab Nawaz on 5/7/24.
//

import XCTest

final class MVVMDemoUITests: XCTestCase {
    let app: XCUIApplication = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        app.launchArguments.append("-logout")
        app.launch()
       // Then, we can try to read this argument and, if detected, set the app state to unauthorized.
        if CommandLine.arguments.contains("-logout") {
            AppState.shared.set(authorized: false)
        }
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLogin() throws {
      LoginScreen(app: app)
          .type(email: "test")
          .type(password: "test")
          .tapSignIn()
          .verifyMessage()
    }

    func testLoginError() throws {
      LoginScreen(app: app)
          .type(email: "test")
          .type(password: "test")
          .tapSignInExpectingError()
    }
    
}


protocol Screen {
    var app: XCUIApplication { get }
}

struct LoginScreen: Screen {
    let app: XCUIApplication

    func type(email: String) -> Self {
        let loginTextField = app.textFields[AccessiblityIdentifiers.LoginScreen.loginTextField]
        loginTextField.tap()
        loginTextField.typeText(email)
        return self
    }

    func type(password: String) -> Self {
        let passwordTextField = app.textFields[AccessiblityIdentifiers.LoginScreen.passwordTextField]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        return self
    }
    
    func tapSignIn() -> Self {
        app.buttons[AccessiblityIdentifiers.LoginScreen.signInButton].tap()
        return self
    }

    func verifyMessage() {
        let message = app.staticTexts["Login Success"]
        XCTAssert(message.exists)
    }
    
    func tapSignInExpectingError() {
        app.buttons[AccessiblityIdentifiers.LoginScreen.signInButton].tap()
        let message = app.staticTexts["message"]
        XCTAssert(message.exists)
    }
}
