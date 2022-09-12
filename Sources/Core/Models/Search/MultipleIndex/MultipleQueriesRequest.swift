//
//  MultipleQueriesRequest.swift
//  
//
//  Created by Vladislav Fitc on 07/04/2020.
//

import Foundation

public struct MultipleQueriesRequest {
    
    public let requests: [MultiSearchQuery]
    public let strategy: MultipleQueriesStrategy
    public init(requests: [MultiSearchQuery], strategy: MultipleQueriesStrategy) {
        self.requests = requests
        self.strategy = strategy
    }
}

extension MultipleQueriesRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case requests
        case strategy
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requests, forKey: .requests)
        try container.encodeIfPresent(strategy, forKey: .strategy)
    }
}
