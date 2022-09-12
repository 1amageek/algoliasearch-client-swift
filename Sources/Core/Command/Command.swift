//
//  Command.swift
//  
//
//  Created by Vladislav Fitc on 10.03.2020.
//

import Foundation

public enum Command { }

extension Command {
    public struct Template: AlgoliaCommand {
        public var method: HTTPMethod = .get
        public let callType: CallType = .read
        public let path = URL.indexesV1
        public let body: Data?
        public let requestOptions: RequestOptions? = nil
    }
}
