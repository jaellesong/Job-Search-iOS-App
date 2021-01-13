//
//  Resume.swift
//  ECA2
//
//  Created by Jaelle Song on 15/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import Foundation

struct Resume: Codable {
    var name: String
    var headline: String
    var city: String
    var email: String
    var about: String
    var workexp: [WorkExp]
    var skills: [String]
    
    struct WorkExp: Codable{
        var title: String
        var company: String
        var city: String
        var to: String
        var from: String
    }
    
}
// initializing data from json file
extension Resume {
    static func resume() -> [Resume] {
        guard
            let url = Bundle.main.url(forResource: "resumeData", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Resume].self, from: data)
        } catch let error {
            print(error)
            return []
        }
    }
}
