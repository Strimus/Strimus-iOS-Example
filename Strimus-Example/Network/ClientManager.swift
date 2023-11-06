//
//  ClientManager.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import Foundation

class ClientManager {
    
    static let shared = ClientManager()
    
    var token: String?
    var uniqueId: String?
    
    var clientId = "client_1"
    
    func auth(uniqueId: String) async throws -> Bool {
       
        self.uniqueId = uniqueId
        
        guard let url = URL(string: "https://straas-api.themachinarium.xyz/auth") else {
            throw URLError(.cannotConnectToHost)
        }
        
        let body = getParameterBody(with: ["key" : "test_key", "secret" : "test_secret", "clientId" : clientId, "uniqueId" : uniqueId])
        
        let request = try await createPostRequest(with: url, body: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(BaseResponse<Auth>.self, from: data)
        self.token = result.data.token
        return result.success
    }
    
    func register(uniqueId: String) async throws -> Bool {
       
        guard let url = URL(string: "https://straas-api.themachinarium.xyz/streamer") else {
            throw URLError(.cannotConnectToHost)
        }
        
        var parameters: [String: Any] = ["key" : "test_key", "secret" : "test_secret", "clientId" : clientId]
        
        parameters["streamer"] = ["uniqueId" : uniqueId,
                                  "name" : "\(uniqueId)name",
                                  "email" : "\(uniqueId)@test.com",
                                  "imageUrl": "https://picsum.photos/500/500",
                                  "profileUrl": "https://linkedin.com/\(uniqueId)"]
        
        let body = getParameterBody(with: parameters)
        
        var request = try await createPostRequest(with: url, body: body)
        request.addValue("Bearer test_key|test_secret", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(BaseResponse<Streamer>.self, from: data)
        return result.success
    }
    
    func getStreams() async throws {
        
    }
    
    private func createPostRequest(with url: URL, body: Data?) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let requestBody = body {
            request.httpBody = requestBody
        }
        return request
    }
    
    private func getParameterBody(with parameters: [String:Any]) -> Data? {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
            return nil
        }
        return httpBody
    }
    
}
