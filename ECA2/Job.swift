//
//  Job.swift
//  ECA
//
//  Created by Jaelle Song on 7/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import Foundation

struct Job: Codable {
    let id: String
    let title: String
    let company: String
    let salary: String
    let location: String
    var saved: Bool
    var applied: Bool
    let date: String
    let description: String
    
}
// initializing data from json file
extension Job {
    static func jobs() -> [Job] {
        guard
            let url = Bundle.main.url(forResource: "jobs", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Job].self, from: data)
        } catch let error {
            print(error)
            return []
        }
    }
}
