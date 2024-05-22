//
//  HomeViewModel.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/8/24.
//

import Foundation
import SwiftUI




class HomeViewModel: ObservableObject, Identifiable {
    
    public var id = UUID()

    @Published var results: [SearchResult] = []
    @Published var searchText: String = "" {
        didSet {
            isSearchEnabled = (searchText.count > 2)
        }
    }
    @Published var isSearchEnabled: Bool = false
    @Published var isLoading: Bool = false
    @Published var navDestination: NavigationDestination? = nil
    @Published public var paths = NavigationPath()
    
    lazy var loginViewModel: LoginViewModel = LoginViewModel()
    lazy var profileViewModel: ProfileViewModel = ProfileViewModel()
    
    func performSearch() {
        isLoading = true
        if searchText.isEmpty {
            isLoading = false
        } else {
            // Uncomment this if you want to see the changes for debugging
            // #if DEBUG
            // print(searchText)
            // results = [SearchResult.mockSearchResult]
            // isLoading = false
            // #else
            let search = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            guard let gURL = URL(string: "https://itunes.apple.com/search?term=\(search)&entity=album") else {
                isLoading = false
                return
            }
            
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: gURL)
                    let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
                        self?.results  = response.results ?? []
                        print(self?.results ?? [])
                    }
                } catch{
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
                        self?.results = []
                    }
                }
            }
            //#endif
        }
    }
    
    var searchResponse: SearchResponse? {
        didSet {
            results = searchResponse?.results ?? []
        }
    }
}

extension HomeViewModel: NavigationCoordinator {
    func push(_ path: NavigationDestination) {
        DispatchQueue.main.async { [weak self] in
            self?.paths.append(path)
        }
    }
    

    public func push(_ path: any Hashable) {
        DispatchQueue.main.async { [weak self] in
            self?.paths.append(path)
        }
    }

    public func popLast() {
        DispatchQueue.main.async { [weak self] in
            self?.paths.removeLast()
        }
    }

}

extension HomeViewModel {
    func onTapNavigateToLogin() {
        navDestination = .login(vm: loginViewModel)
        self.push(.login(vm: loginViewModel))
        
     }
     
     func onTapNavigateToProfile() {
       navDestination = .profile(vm: profileViewModel)
     }
    
//    func nextButtonSelected() {
//        self.navigator.push(
//            RootViewModel.Path.second(
//                SecondContentViewModel(navigator: navigator, text: "Second!")
//            )
//        )
//    }

}
