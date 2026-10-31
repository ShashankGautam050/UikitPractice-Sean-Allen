//
//  ErrorMessage.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 20/10/26.
//

import Foundation
enum UIError : String,Error {
    case invalidUrl = "Unable to complete the request.Please try again."
    case internetIssue = "Please check your internet connection."
    case invalidData = "Invalid data.Please try again."
    case invalidResponse = "Invalid response.Please try again."
    
    
    
}
