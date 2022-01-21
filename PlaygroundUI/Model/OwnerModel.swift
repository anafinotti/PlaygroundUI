//
//  OwnerModel.swift
//  PlaygroundUI
//
//  Created by Ana Finotti on 20/01/22.
//

import Foundation

struct OwnerModel: Codable {
    
    var id: Int?
    var avatarUrl: String?
    var url: String?
    var login: String?
    
    init(id: Int? = nil, avatarUrl: String? = nil, url: String? = nil, login: String? = nil) {
        
        self.id = id
        self.avatarUrl = avatarUrl
        self.url = url
        self.login = login
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case avatarUrl = "avatar_url"
        case url = "url"
        case login = "login"
    }
}
