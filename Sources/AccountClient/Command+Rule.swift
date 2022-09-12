//
//  Command+Rule.swift
//  
//
//  Created by Vladislav Fitc on 04/05/2020.
//

import Foundation

extension Command {
    
    enum Rule {
        
        struct Save: AlgoliaCommand {
            
            let method: HTTPMethod = .put
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, rule: Core.Rule, forwardToReplicas: Bool?, requestOptions: RequestOptions?) {
                var options = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    options.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = options
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.rules)
                    .appending(rule.objectID)
                self.body = rule.httpBody
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
                    .appending(.rules)
                    .appending(objectID)
            }
            
        }
        
        struct Delete: AlgoliaCommand {
            
            let method: HTTPMethod = .delete
            let callType: CallType = .write
            let path: URL
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, objectID: ObjectID, forwardToReplicas: Bool?, requestOptions: RequestOptions?) {
                var options = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    options.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = options
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.rules)
                    .appending(objectID)
            }
            
        }
        
        struct Search: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .read
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, query: RuleQuery, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.rules)
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
                var options = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    options.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                self.requestOptions = options
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.rules)
                    .appending(.clear)
            }
            
        }
        
        struct SaveList: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .write
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(indexName: IndexName, rules: [Core.Rule], forwardToReplicas: Bool?, clearExistingRules: Bool?, requestOptions: RequestOptions?) {
                var options = requestOptions ?? RequestOptions()
                if let forwardToReplicas = forwardToReplicas {
                    options.setParameter(String(forwardToReplicas), forKey: .forwardToReplicas)
                }
                if let clearExistingRules = clearExistingRules {
                    options.setParameter(String(clearExistingRules), forKey: .clearExistingRules)
                }
                self.requestOptions = options
                self.path = URL
                    .indexesV1
                    .appending(indexName)
                    .appending(.rules)
                    .appending(.batch)
                self.body = rules.httpBody
            }
            
        }
        
    }
    
}
