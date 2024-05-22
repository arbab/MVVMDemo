//
//  LoginView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
  @StateObject var viewModel: LoginViewModel
  
  var body: some View {
    VStack {
      Text(viewModel.title)
    }
    .navigationTitle(viewModel.navigationTitle)
  }
}

struct ProfileView: View {
  @StateObject var viewModel: ProfileViewModel
  
  var body: some View {
    VStack {
      Text(viewModel.title)
    }
    .navigationTitle(viewModel.navigationTitle)
  }
}
