//
//  ABTest.swift
//  
//
//  Created by Vladislav Fitc on 28/05/2020.
//

import Foundation

/// ABTest applied to compare analytics performance between two indices.
public struct ABTest {
    
    /// Name of the ABTest
    public let name: String
    
    /// A date to automatically end an ABTest at a specific time.
    public let endAt: Date
    
    /// The base index Variant.
    public let variantA: Variant
    
    /// The index Variant to test against.
    public let variantB: Variant
    
    public init(name: String,
                endAt: Date,
                variantA: Variant,
                variantB: Variant) {
        self.name = name
        self.endAt = endAt
        self.variantA = variantA
        self.variantB = variantB
    }
}

extension ABTest: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case endAt
        case variants
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.endAt = try container.decode(Date.self, forKey: .endAt)
        let variants: [Variant] = try container.decode([ABTest.Variant].self, forKey: .variants)
        self.variantA = variants[0]
        self.variantB = variants[1]
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(endAt, forKey: .endAt)
        try container.encode([variantA, variantB], forKey: .variants)
    }
    
}
