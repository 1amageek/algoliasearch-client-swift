//
//  RequestOptions.swift
//  
//
//  Created by Vladislav Fitc on 19/02/2020.
//

import Foundation

/**
 Every endpoint can configure a request locally by passing additional
 headers, urlParameters, body, writeTimeout, readTimeout.
 */
public struct RequestOptions {
    
    public var headers: [HTTPHeaderKey: String]
    public var urlParameters: [HTTPParameterKey: String?]
    public var writeTimeout: TimeInterval?
    public var readTimeout: TimeInterval?
    public var body: [String: Any]?
    
    public init(headers: [HTTPHeaderKey: String] = [:],
                urlParameters: [HTTPParameterKey: String?] = [:],
                writeTimeout: TimeInterval? = nil,
                readTimeout: TimeInterval? = nil,
                body: [String: Any]? = nil) {
        self.headers = headers
        self.urlParameters = urlParameters
        self.writeTimeout = writeTimeout
        self.readTimeout = readTimeout
        self.body = body
    }
    
    /// Add a header with key and value to headers.
    public mutating func setHeader(_ value: String?, forKey key: HTTPHeaderKey) {
        headers[key] = value
    }
    
    /// Add a url parameter with key and value to urlParameters.
    public mutating func setParameter(_ value: String?, forKey key: HTTPParameterKey) {
        urlParameters[key] = value
    }
    
    /// Set timeout for a call type
    public mutating func setTimeout(_ timeout: TimeInterval?, for callType: CallType) {
        switch callType {
            case .read:
                self.readTimeout = timeout
            case .write:
                self.writeTimeout = timeout
        }
    }
    
    /// Get timeout for a call type
    public func timeout(for callType: CallType) -> TimeInterval? {
        switch callType {
            case .read:
                return readTimeout
            case .write:
                return writeTimeout
        }
    }
    
}

public struct HTTPParameterKey: RawRepresentable, Hashable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

extension HTTPParameterKey: ExpressibleByStringInterpolation {
    
    public init(stringLiteral value: String) {
        rawValue = value
    }
    
}

extension HTTPParameterKey {
    
    public static var attributesToRetreive: HTTPParameterKey { #function }
    public static var forwardToReplicas: HTTPParameterKey { #function }
    public static var clearExistingRules: HTTPParameterKey { #function }
    public static var replaceExistingSynonyms: HTTPParameterKey { #function }
    public static var createIfNotExists: HTTPParameterKey { #function }
    public static var cursor: HTTPParameterKey { #function }
    public static var indexName: HTTPParameterKey { #function }
    public static var offset: HTTPParameterKey { #function }
    public static var limit: HTTPParameterKey { #function }
    public static var length: HTTPParameterKey { #function }
    public static var type: HTTPParameterKey { #function }
    public static var language: HTTPParameterKey { #function }
    public static var aroundLatLng: HTTPParameterKey { #function }
    public static var page: HTTPParameterKey { #function }
    public static var hitsPerPage: HTTPParameterKey { #function }
    public static var getClusters: HTTPParameterKey { #function }
}

extension HTTPHeaderKey {
    
    public static let contentType: HTTPHeaderKey = "Content-Type"
    public static let algoliaUserID: HTTPHeaderKey = "X-Algolia-User-ID"
    public static let forwardedFor: HTTPHeaderKey = "X-Forwarded-For"
    public static let applicationID: HTTPHeaderKey = "X-Algolia-Application-Id"
    public static let apiKey: HTTPHeaderKey = "X-Algolia-API-Key"
    public static let userAgent: HTTPHeaderKey = "User-Agent"
}

extension HTTPHeaderKey: ExpressibleByStringInterpolation {
    
    public init(stringLiteral value: String) {
        rawValue = value
    }
}

public struct HTTPHeaderKey: RawRepresentable, Hashable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

//extension Optional where Wrapped == RequestOptions {
//    
//    public func unwrapOrCreate() -> RequestOptions {
//        return self ?? RequestOptions()
//    }
//    
//    public func updateOrCreate(_ parameters: @autoclosure () -> [HTTPParameterKey: String?]) -> RequestOptions? {
//        let parameters = parameters()
//        guard !parameters.isEmpty else { return self }
//        var mutableRequestOptions = unwrapOrCreate()
//        for (key, value) in parameters {
//            mutableRequestOptions.setParameter(value, forKey: key)
//        }
//        return mutableRequestOptions
//    }
//}
