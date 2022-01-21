//
//  RepositoryService.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation
import Combine
import Alamofire

protocol RepositoryServiceProtocol {
    
    func fetchRepositories(currentPage: Int) -> AnyPublisher<DataResponse<RepositoriesModel, NetworkError>, Never>
}


class RepositoryService {
    
    static let shared: RepositoryServiceProtocol = RepositoryService()
    private init() { }
}

extension RepositoryService: RepositoryServiceProtocol {
    
    func fetchRepositories(currentPage: Int) -> AnyPublisher<DataResponse<RepositoriesModel, NetworkError>, Never> {
        
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(currentPage)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: RepositoriesModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
