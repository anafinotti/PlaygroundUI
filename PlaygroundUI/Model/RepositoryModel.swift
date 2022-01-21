//
//  RepositoryModel.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation

struct RepositoriesModel: Codable {
    
    var repositories: [RepositoryModel]?
    var hasMorePages: Bool?
    var totalCount: Int?
    
    init(repositories: [RepositoryModel]? = nil, hasMorePages: Bool? = nil, totalCount: Int? = nil) {
        
        self.repositories = repositories
        self.hasMorePages = hasMorePages
        self.totalCount = totalCount
    }
    
    enum CodingKeys: String, CodingKey {
        
        case repositories = "items"
        case hasMorePages = "incomplete_results"
        case totalCount = "total_count"
    }
}

struct RepositoryModel: Identifiable, Codable {
    
    var id: Int?
    var name: String?
    var owner: OwnerModel?
    var url: String?
    var description: String?
}
