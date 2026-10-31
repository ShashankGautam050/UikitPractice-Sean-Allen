//
//  Follower.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 26/09/26.
//

import Foundation

nonisolated struct Follower: Codable, Hashable, Sendable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

