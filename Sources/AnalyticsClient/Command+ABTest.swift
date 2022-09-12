//
//  Command+ABTest.swift
//  
//
//  Created by Vladislav Fitc on 28/05/2020.
//

import Foundation

public typealias AnalyticsABTest = ABTest

extension Command {
    
    public enum ABTest {
        
        public struct Add: AlgoliaCommand {
            
            public let method: HTTPMethod = .post
            public let callType: CallType = .write
            public let path = URL.ABTestsV2
            public let body: Data?
            public let requestOptions: RequestOptions?
            
            public init(abTest: AnalyticsABTest, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.body = abTest.httpBody
            }
        }
        
        public struct Get: AlgoliaCommand {
            
            public let method: HTTPMethod = .get
            public let callType: CallType = .read
            public let path: URL
            public let requestOptions: RequestOptions?
            
            public init(abTestID: ABTestID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .ABTestsV2
                    .appending(abTestID)
            }
        }
        
        public struct Stop: AlgoliaCommand {
            
            public let method: HTTPMethod = .post
            public let callType: CallType = .write
            public let path: URL
            public let requestOptions: RequestOptions?
            
            public init(abTestID: ABTestID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .ABTestsV2
                    .appending(abTestID)
                    .appending(.stop)
            }
        }
        
        public struct Delete: AlgoliaCommand {
            
            public let method: HTTPMethod = .delete
            public let callType: CallType = .write
            public let path: URL
            public let requestOptions: RequestOptions?
            
            public init(abTestID: ABTestID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .ABTestsV2
                    .appending(abTestID)
            }
        }
        
        public struct List: AlgoliaCommand {
            
            public let method: HTTPMethod = .get
            public let callType: CallType = .read
            public let path = URL.ABTestsV2
            public let requestOptions: RequestOptions?
            
            public init(offset: Int?, limit: Int?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                requestOptions.setParameter(offset.flatMap(String.init), forKey: .offset)
                requestOptions.setParameter(limit.flatMap(String.init), forKey: .limit)
                self.requestOptions = requestOptions
            }
        }
    }
}
