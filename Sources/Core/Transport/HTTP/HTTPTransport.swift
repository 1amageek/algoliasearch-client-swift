//
//  HTTPTransport.swift
//  
//
//  Created by Vladislav Fitc on 19/02/2020.
//

import Foundation

/**
 The transport layer is responsible of the serialization/deserialization and the retry strategy.
 */
public class HTTPTransport: Transport {
    
    public var applicationID: ApplicationID { credentials.applicationID }
    
    public var apiKey: APIKey { credentials.apiKey }
    
    let requestBuilder: HTTPRequestBuilder
    let operationLauncher: OperationLauncher
    let credentials: Credentials
    
    init(requestBuilder: HTTPRequestBuilder, operationLauncher: OperationLauncher, credentials: Credentials) {
        self.requestBuilder = requestBuilder
        self.operationLauncher = operationLauncher
        self.credentials = credentials
    }
    
    public convenience init(requester: HTTPRequester, configuration: Configuration, retryStrategy: RetryStrategy, credentials: Credentials, operationLauncher: OperationLauncher) {
        let requestBuilder = HTTPRequestBuilder(requester: requester, retryStrategy: retryStrategy, configuration: configuration, credentials: credentials)
        self.init(requestBuilder: requestBuilder, operationLauncher: operationLauncher, credentials: credentials)
    }
    
    public func execute<Command: AlgoliaCommand, Response: Decodable, Output>(_ command: Command, transform: @escaping (Response) -> Output, completion: @escaping (Result<Output, Swift.Error>) -> Void) -> Operation & TransportTask {
        let request = requestBuilder.build(for: command, transform: transform, with: completion)
        return operationLauncher.launch(request)
    }
    
    public func execute<Command: AlgoliaCommand, Response: Decodable, Output>(_ command: Command, transform: @escaping (Response) -> Output) throws -> Output {
        let request = requestBuilder.build(for: command, transform: transform, responseType: Output.self)
        return try operationLauncher.launchSync(request)
    }
    
    @discardableResult func launch<O: Operation>(_ operation: O) -> O {
        return operationLauncher.launch(operation)
    }
    
    func launch<O: OperationWithResult>(_ operation: O) throws -> O.ResultValue {
        return try operationLauncher.launchSync(operation)
    }
    
}
