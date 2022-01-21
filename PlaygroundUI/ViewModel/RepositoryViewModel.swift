//
//  RepositoryViewModel.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published var repositoriesList = RepositoriesModel()
    @Published var repositoriesLoadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: RepositoryServiceProtocol
    
    init( dataManager: RepositoryServiceProtocol = RepositoryService.shared) {
        
        self.dataManager = dataManager
        getRepositories()
    }
    
    func getRepositories() {
        
        dataManager.fetchRepositories()
            .sink { (dataResponse) in
                if dataResponse.error != nil { self.createAlert(with: dataResponse.error!) }
                else { self.repositoriesList = dataResponse.value ?? RepositoriesModel() }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        
        self.repositoriesLoadingError = error.backendError == nil ?
        error.initialError.localizedDescription : (error.backendError?.message ?? "")
        
        self.showAlert = true
    }
}
