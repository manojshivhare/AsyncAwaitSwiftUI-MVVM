//
//  WebServicesManager.swift
//  AsyncAwaitSwiftuiDemo
//
//  Created by Manoj Shivhare on 04/06/24.
//

import Foundation
final class WebServicesManager{
    
    static func getUserData() async throws -> [UserModel]{
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else { throw ErrorCases.invalidResponse }
        
        do{
            return try JSONDecoder().decode([UserModel].self, from: data)
        }catch{
            throw ErrorCases.invalidData
        }
    }
}

enum ErrorCases: LocalizedError{
    case invalidUrl
    case invalidResponse
    case invalidData
    
    var localisedDescription: String?{
        switch self {
        case .invalidUrl:
            return "Invalide url found"
        case .invalidResponse:
            return "Invalide response found"
        case .invalidData:
            return "Invalide data found"
        }
    }
}
