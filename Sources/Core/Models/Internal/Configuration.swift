//
//  Configuration.swift
//  
//
//  Created by Vladislav Fitc on 20/02/2020.
//

import Foundation

public protocol Configuration {
    
    /// The timeout for each request when performing write operations (POST, PUT ..).
    var writeTimeout: TimeInterval { get }
    
    /// The timeout for each request when performing read operations (GET).
    var readTimeout: TimeInterval { get }
    
    /// LogLevel to display in the console.
    var logLevel: LogLevel { get }
    
    /// List of hosts and back-up host used to perform a custom retry logic.
    var hosts: [RetryableHost] { get set }
    
    /// Default headers that should be applied to every request.
    var defaultHeaders: [HTTPHeaderKey: String]? { get }
    
    var batchSize: Int { get }
    
}

extension Configuration {
    
    public func timeout(for callType: CallType) -> TimeInterval {
        switch callType {
            case .read:
                return readTimeout
            case .write:
                return writeTimeout
        }
    }
}

public struct DefaultConfiguration: Configuration {
    
    public static let `default`: Configuration = DefaultConfiguration()
    
    public let writeTimeout: TimeInterval = 30
    public let readTimeout: TimeInterval = 5
    public let logLevel: LogLevel = .info
    public var hosts: [RetryableHost] = []
    public let defaultHeaders: [HTTPHeaderKey: String]? = [:]
    public let batchSize: Int = 1000
}
