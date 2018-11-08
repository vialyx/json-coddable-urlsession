//
//  ViewController.swift
//  JsonCoddableUrlSession
//
//  Created by Maksim Vialykh on 08/11/2018.
//  Copyright © 2018 Vialyx. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    let repository = Repository(apiClient: APIClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.getFlights { (result) in
            switch result {
            case .success(let items):
                print("\(self) retrive flights: \(items)")
            case .failure(let error):
                print("\(self) retrive error on get flights: \(error)")
            }
        }
    }

}
