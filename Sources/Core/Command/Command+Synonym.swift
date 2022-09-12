//
//  Command+Synonym.swift
//  
//
//  Created by Vladislav Fitc on 11/05/2020.
//

import Foundation

extension Command {
    
    enum Synonym {
        
        struct Save: AlgoliaCommand {
            
            let method: HTTPMethod = .put
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, synonym: Core.Synonym, forwardToReplicas: Bool?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    requestOptions.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(synonym.objectID)
                self.body = synonym.httpBody
            }
            
        }
        
        struct SaveList: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, synonyms: [Core.Synonym], forwardToReplicas: Bool?, clearExistingSynonyms: Bool?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    requestOptions.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                if let clearExistingSynonyms = clearExistingSynonyms {
                    requestOptions.setParameter(String(clearExistingSynonyms), forKey: .replaceExistingSynonyms)
                }                                
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(.batch)
                self.body = synonyms.httpBody
            }
            
        }
        
        struct Get: AlgoliaCommand {
            
            let method: HTTPMethod = .get
            let callType: CallType = .read
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(objectID)
            }
            
        }
        
        struct Delete: AlgoliaCommand {
            
            let method: HTTPMethod = .delete
            let callType: CallType = .write
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, forwardToReplicas: Bool?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    requestOptions.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(objectID)
            }
            
        }
        
        struct Search: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .read
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, query: SynonymQuery, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(.search)
                self.body = query.httpBody
            }
            
        }
        
        struct Clear: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, forwardToReplicas: Bool?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    requestOptions.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.synonyms)
                    .appending(.clear)
            }
            
        }
        
    }
    
}
