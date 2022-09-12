//
//  Waitable.swift
//  
//
//  Created by Vladislav Fitc on 01/02/2021.
//

import Foundation

public struct Waitable: AnyWaitable {
    
    public var asyncCall: (TimeInterval?, RequestOptions?, @escaping ResultCallback<Empty>) -> Void
    public var syncCall: (TimeInterval?, RequestOptions?) throws -> Void
    
    public init(index: Index, taskID: TaskID) {
        asyncCall = { timeout, requestOptions, completion in
            index.waitTask(withID: taskID, timeout: timeout, requestOptions: requestOptions, completion: { result in
                completion(result.map { _ in .empty })
            })
        }
        syncCall = { try index.waitTask(withID: taskID, timeout: $0, requestOptions: $1) }
    }
    
    public init(
        asyncCall: @escaping (TimeInterval?, RequestOptions?, @escaping ResultCallback<Empty>) -> Void,
        syncCall: @escaping (TimeInterval?, RequestOptions?) throws -> Void
    ) {
        self.asyncCall = asyncCall
        self.syncCall = syncCall
    }
    
    public init(client: SearchClient, task: IndexedTask) {
        self.init(index: client.index(withName: task.indexName), taskID: task.taskID)
    }
    
    public init(client: SearchClient, taskID: AppTaskID) {
        asyncCall = { timeout, requestOptions, completion in client.waitTask(withID: taskID, timeout: timeout, requestOptions: requestOptions, completion: { result in completion(result.map { _ in .empty }) }) }
        syncCall = { try client.waitTask(withID: taskID, timeout: $0, requestOptions: $1) }
    }
    
    public func wait(timeout: TimeInterval? = nil,
                     requestOptions: RequestOptions? = nil) throws {
        try syncCall(timeout, requestOptions)
    }
    
    public func wait(timeout: TimeInterval? = nil,
                     requestOptions: RequestOptions? = nil,
                     completion: @escaping (Result<Empty, Swift.Error>) -> Void) {
        asyncCall(timeout, requestOptions, completion)
    }
    
}
