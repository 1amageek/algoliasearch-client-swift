//
//  Command+Indexing.swift
//  
//
//  Created by Vladislav Fitc on 10.03.2020.
//

import Foundation

extension Command {
    
    enum Indexing {
        
        struct SaveObject: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init<T: Encodable>(indexName: IndexName, record: T, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                self.body = record.httpBody
            }
        }
        
        struct GetObject: AlgoliaCommand {
            
            let method: HTTPMethod = .get
            let callType: CallType = .read
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, attributesToRetrieve: [Attribute], requestOptions: RequestOptions?) {
                var requestOptions = requestOptions
                if !attributesToRetrieve.isEmpty {
                    let attributesValue = attributesToRetrieve.map(\.rawValue).joined(separator: ",")
                    requestOptions?.setParameter(attributesValue, forKey: .attributesToRetreive)
                }
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(objectID)
            }
        }
        
        struct ReplaceObject: AlgoliaCommand {
            
            let method: HTTPMethod = .put
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init<T: Encodable>(indexName: IndexName, objectID: ObjectID, replacementObject record: T, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(objectID)
                self.body = record.httpBody
            }
        }
        
        struct DeleteObject: AlgoliaCommand {
            
            let method: HTTPMethod = .delete
            let callType: CallType = .write
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(objectID)
            }
            
        }
        
        struct DeleteByQuery: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, query: Core.DeleteByQuery, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.deleteByQuery)
                self.body = ParamsWrapper(query.urlEncodedString).httpBody
            }
        }
        
        struct PartialUpdate: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, partialUpdate: Core.PartialUpdate, createIfNotExists: Bool?, requestOptions: RequestOptions?) {
                var options = requestOptions ?? RequestOptions()
                if let createIfNotExists = createIfNotExists {
                    options.setParameter(String(createIfNotExists), forKey: .createIfNotExists)
                }
                self.requestOptions = options
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(objectID)
                    .appending(.partial)
                self.body = partialUpdate.httpBody
            }
        }
        
        struct ClearObjects: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.clear)
            }
        }
    }
}
