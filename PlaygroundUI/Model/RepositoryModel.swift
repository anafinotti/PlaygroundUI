//
//  RepositoryModel.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation

struct RepositoriesModel: Codable {
    
    var repositories: [RepositoryModel]?
    
    init(repositories: [RepositoryModel]? = nil) {
        
        self.repositories = repositories
    }
    
    enum CodingKeys: String, CodingKey {
        
        case repositories = "items"
    }
}

struct RepositoryModel: Identifiable, Codable {
    
    var id: Int?
    var name: String?
    var owner: OwnerModel?
    var url: String?
    var description: String?
}
