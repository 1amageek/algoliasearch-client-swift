//
//  AlgoliaCommand.swift
//  
//
//  Created by Vladislav Fitc on 10.03.2020.
//

import Foundation

public protocol AlgoliaCommand {
    
    var method: HTTPMethod { get }
    var callType: CallType { get }
    var path: URL { get }
    var body: Data? { get }
    var requestOptions: RequestOptions? { get }
}

extension AlgoliaCommand {
    
    public var body: Data? { nil }
    
}
