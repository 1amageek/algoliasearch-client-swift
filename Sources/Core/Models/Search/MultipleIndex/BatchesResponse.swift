//
//  BatchesResponse.swift
//  
//
//  Created by Vladislav Fitc on 04/04/2020.
//

import Foundation

public struct BatchesResponse {
    
    /// A list of TaskIndex to use with .waitAll.
    public let tasks: [IndexedTask]
    
    /// List of ObjectID affected by .multipleBatchObjects.
    public let objectIDs: [ObjectID?]
    
}

extension BatchesResponse {
    
    init(indexName: IndexName, responses: [BatchResponse]) {
        let tasks: [IndexedTask] = responses.map { .init(indexName: indexName, taskID: $0.taskID) }
        let objectIDs = responses.map(\.objectIDs).flatMap { $0 }
        self.init(tasks: tasks, objectIDs: objectIDs)
    }
    
}

extension BatchesResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case tasks = "taskID"
        case objectIDs
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawTasks: [String: Int] = try container.decode([String : Int].self, forKey: .tasks)
        self.tasks = rawTasks.map { rawIndexName, rawTaskID in IndexedTask(indexName: .init(rawValue: rawIndexName), taskID: .init(rawValue: String(rawTaskID))) }
        self.objectIDs = try container.decode([ObjectID?].self, forKey: .objectIDs)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let rawTasks = [String: String](uniqueKeysWithValues: tasks.map { ($0.indexName.rawValue, $0.taskID.rawValue) })
        try container.encode(rawTasks, forKey: .tasks)
        try container.encode(objectIDs, forKey: .objectIDs)
    }
}
