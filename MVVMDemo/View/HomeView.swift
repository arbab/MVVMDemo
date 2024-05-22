//
//  HomeView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/8/24.
//

import Foundation
import SwiftUI
import Charts

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var navDestination: NavigationDestination = .none

    fileprivate func buildHomeView() -> VStack<TupleView<(Button<Text>, NavigationLink<some View, LoginView>, NavigationLink<some View, ProfileView>)>> {
        return VStack {
            Button(viewModel.navDestination?.title() ?? "") {
                viewModel.onTapNavigateToLogin()
            }
            
            NavigationLink(destination: {
                LoginView(viewModel: viewModel.loginViewModel)
            }) {
                Text(viewModel.loginViewModel.navigationTitle).padding()
            }
            NavigationLink(destination: {
                ProfileView(viewModel: viewModel.profileViewModel)
            }) {
                Text(viewModel.profileViewModel.navigationTitle).padding()
            }
        }
    }
    
    var body: some View {
        // Uncommnent this if you want to see the changes for debugging
        // #if DEBUG
        //    Self._logChanges()
        // #endif
        if #available(iOS 16, *) {
            return NavigationStack (path: Binding(projectedValue: $viewModel.paths)) {
                Text("Hello there, welcome back!")
                ScrollListView(viewModel: viewModel)
                    .navigationTitle("MVVM Demo")
                    .navigationBarTitleDisplayMode(.large)
            }.navigationBarTitle("Start")
        } else {
            return NavigationView {
                buildHomeView()
                .navigationBarTitle("Start")
                .onChange(of: viewModel.navDestination) { newValue in
                    guard let newNavDestination = newValue else {
                        navDestination = .none
                        return
                    }
                    navDestination = newNavDestination
                }
            }
        }
    }
    
    // Can be moved in a separate factory and injected here like a dependency
    @ViewBuilder
    private func buildNextView() -> some View {
        switch navDestination {
        case .login(let vm):
            LoginView(viewModel: vm)
        case .profile(let vm):
            ProfileView(viewModel: vm)
        case .none:
            EmptyView()
        case .chartView(vm: let vm):
            ChartView(viewModel: vm)
        }
    }
    
    
}

struct ScrollListView: View {
    
    // using a escaping closure allows the viewmodel to be created and passed once other wise it will be created along with the view when parant invalidates the view
    /* https://stackoverflow.com/questions/62635914/initialize-stateobject-with-a-parameter-in-swiftui //
    init(viewModel: @autoclosure @escaping () -> HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel()) // viewModel
    }
    
    @StateObject private var viewModel: HomeViewModel
    */
    
    @StateObject var viewModel: HomeViewModel
    
    
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $viewModel.searchText)
                    .accessibilityIdentifier(AccessiblityIdentifiers.HomeScreen.searchTextField)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.words)
                    .background()
                    .cornerRadius(7)
                    .padding(1)
                if viewModel.isLoading {
                    ProgressView()
                        .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                }
                Button{
                    viewModel.performSearch()
                } label: {
                    Text ("Search")
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .teal : .white)
                        .padding(10)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .opacity(viewModel.isSearchEnabled ? 1.0: 0.5)
                        .background(colorScheme == .dark ? .gray : .blue)
                        .cornerRadius(10)
                    
                }
                .accessibilityIdentifier(AccessiblityIdentifiers.HomeScreen.searchButton)
                .fixedSize()
            }
            .padding(5)

            // TriggerValueExample()
            List {
                ForEach(viewModel.results, id: \.id) { result in
                    let srvm = SearchResultsRowViewModel(model: result)
                    SearchResultsRow(result: srvm)
                }
            }

        }
        .onKeyPress(action: { keyPress in
            print("""
                New key event:
                Key: \(keyPress.characters)
                Modifiers: \(keyPress.modifiers)
                Phase: \(keyPress.phase)
                Debug description: \(keyPress.debugDescription)
            """)
            if keyPress.key == .return {
                viewModel.performSearch()
            }
            return .ignored
        })
    }
}


#Preview(body: {
    HomeView()
})
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

extension Color {
    static let adaptiveWhite = Color("adaptiveWhite")
}


struct TriggerValueExample: View {
    let messages: [String] = ["Some Message1", "Some Message2", "Some Message3", "Some Message4", "Some Message5"]
    var body: some View {
        List (messages, id: \.self) { message in
            Text (verbatim: message)
        }
        .sensoryFeedback(.success, trigger: messages) { oldValue, newValue in
            //trigger the .success haptic when the difference between two
            oldValue != newValue
        }
    }
}

