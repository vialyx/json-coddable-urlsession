//
//  Repository.swift
//  JsonCoddableUrlSession
//
//  Created by Maksim Vialykh on 08/11/2018.
//  Copyright © 2018 Vialyx. All rights reserved.
//

import Foundation

// TODO: - Move to the separated file FlightData.swift
struct FlightData: Codable {
    let Airline: String
    let Flight: String
    let ActualTime: String
}

final class Repository {
    
    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getFlights(_ completion: @escaping ((Result<[FlightData]>) -> Void)) {
        let resource = Resource(url: URL(string: "https://desolate-beyond-86929.herokuapp.com/arrival")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([FlightData].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
