//
//  NavigationVIewModel.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
  let title = "Im a Login view"
  let navigationTitle = "Login"
}

class ProfileViewModel: ObservableObject {
  let title = "Im a Profile view"
  let navigationTitle = "Profile"
}

class ChartViewModel: ObservableObject {
  let title = "Im a Chart View"
  let navigationTitle = "Charts"
}


protocol NavigationCoordinator {
    func push(_ path: NavigationDestination)
    func popLast()
}


// Lets introduce enum with all possible destinations
enum NavigationDestination: Hashable {
    case login(vm: LoginViewModel)
    case profile(vm: ProfileViewModel)
    case chartView(vm: ChartViewModel)
    case none

 
    func destination() -> any Hashable {
        
        switch self {
        case .login(let viewModel):
            LoginView(viewModel: viewModel) as! (any Hashable)
        case .profile(let viewModel):
            ProfileView(viewModel: viewModel) as! (any Hashable)
        case .chartView(let viewModel):
            ChartView(viewModel: viewModel) as! (any Hashable)
        case .none:
            HomeView() as! (any Hashable)
        }
    }
    
    func title() -> String {
        
        switch self {
        case .login(let viewModel):
            viewModel.navigationTitle
        case .profile(let viewModel):
            viewModel.navigationTitle
        case .chartView(let viewModel):
            viewModel.navigationTitle
        case .none:
            "HomeView"
        }
    }
    
  func hash(into hasher: inout Hasher) {
    var index = 0
    switch self {
    case .login:
      index = 1
    case .profile:
      index = 2
    case .chartView:
      index = 2
    case .none:
      index = 0
    }
    hasher.combine(index)
  }
  
  static func == (
    lhs: NavigationDestination,
    rhs: NavigationDestination
  ) -> Bool {
    lhs.hashValue == rhs.hashValue
  }
}

//let navigationTitle = "Navigation example"
//let navigateToLoginTitle = "Navigate to Login"
//let navigateToProfileTitle = "Navigate to Profile"
