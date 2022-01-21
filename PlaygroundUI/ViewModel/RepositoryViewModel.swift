//
//  RepositoryViewModel.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published var repositoryList = RepositoriesModel()
    @Published var repositoriesLoadingError: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoadingPage = false

    private var currentPage = 1
    private var canLoadMorePages = true
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: RepositoryServiceProtocol
    
    init( dataManager: RepositoryServiceProtocol = RepositoryService.shared) {
        
        self.dataManager = dataManager
        getRepositories()
    }
    
    func getRepositories() {
        
        self.isLoadingPage = true
        
        dataManager.fetchRepositories(currentPage: self.currentPage)
            .handleEvents(receiveOutput: { response in
                
                self.isLoadingPage = false

                if let error = response.error { self.createAlert(with: error) }
                else if let repositories = response.value {
                    
                    self.canLoadMorePages = repositories.hasMorePages ?? false
                    self.currentPage += 1
                }
            })
            .sink { (response) in
                
                if let error = response.error { self.createAlert(with: error) }
                else if let repositoryList = response.value {
                    
                    var repositories = self.repositoryList.repositories
                    var newRepositoryList = RepositoriesModel()
                    
                    if repositories != nil,
                       let newRepositories = repositoryList.repositories {
                        
                        repositories!.append(contentsOf: newRepositories)
                    }
                    
                    newRepositoryList = repositoryList
                    if repositories != nil { newRepositoryList.repositories = repositories }
                    
                    self.repositoryList = newRepositoryList
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        
        self.repositoriesLoadingError = error.backendError == nil ?
        error.initialError.localizedDescription : (error.backendError?.message ?? "")
        
        self.showAlert = true
    }
}
