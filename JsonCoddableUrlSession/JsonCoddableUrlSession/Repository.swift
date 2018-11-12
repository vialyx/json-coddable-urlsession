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

enum RepositoryType {
    case local, remote
}

final class Repository {
    
    private let apiClient: APIClient!
    private let database: Database!
    
    init(apiClient: APIClient, database: Database) {
        self.apiClient = apiClient
        self.database = database
    }
    
    func getFlights(_ type: RepositoryType, _ completion: @escaping ((Result<[FlightData]>) -> Void)) {
        switch type {
        case .local:
            completion(.success(database.get()))
        case .remote:
            let resource = Resource(url: URL(string: "https://desolate-beyond-86929.herokuapp.com/arrival")!)
            apiClient.load(resource) { [weak self] (result) in
                switch result {
                case .success(let data):
                    do {
                        let items = try JSONDecoder().decode([FlightData].self, from: data)
                        self?.database.save(flights: items)
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
    
}
