//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkinError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL: \(url)"
            case .unknown: return "Unknown Error occured"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output:$0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    static func handleCompletion(completion: Subscribers.Completion<any Error>){
        switch completion {
        case .finished: break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 299 else {
            throw NetworkinError.badURLResponse(url: url)
            }
        return output.data
    }
}
