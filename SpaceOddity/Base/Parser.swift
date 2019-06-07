//
//  Parser.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class Parser {
    
    static func decode<T: Codable>(data: Data) -> T? {
        
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
    
}
