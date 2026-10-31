//
//  User.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 26/09/26.
//

import Foundation

struct User : Codable{
    var login : String
    var avatarURL : String
    var name : String
    var location : String?
    var bio : String?
    var publicRepos : Int
    var publicGists : Int
    var htmlURL : String
    var following : Int
    var follwers : Int
    var createdAt : String
    
}
