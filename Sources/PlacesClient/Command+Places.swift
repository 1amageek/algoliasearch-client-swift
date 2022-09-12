//
//  Command+Places.swift
//  
//
//  Created by Vladislav Fitc on 10/04/2020.
//

import Foundation

extension Command {
    
    enum Places {
        
        struct Search: AlgoliaCommand {
            
            let method: HTTPMethod = .post
            let callType: CallType = .read
            let path: URL
            let body: Data?
            let requestOptions: RequestOptions?
            
            init(query: PlacesQuery, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .places
                    .appending(.query)
                self.body = query.httpBody
            }
            
        }
        
        struct GetObject: AlgoliaCommand {
            
            let method: HTTPMethod = .get
            let callType: CallType = .read
            let path: URL
            let requestOptions: RequestOptions?
            
            init(objectID: ObjectID, requestOptions: RequestOptions?) {
                self.requestOptions = requestOptions
                self.path = URL
                    .places
                    .appending(objectID)
            }
            
        }
        
        struct ReverseGeocoding: AlgoliaCommand {
            
            let method: HTTPMethod = .get
            let callType: CallType = .read
            let path: URL
            let requestOptions: RequestOptions?
            
            init(geolocation: Point, language: Language?, hitsPerPage: Int?, requestOptions: RequestOptions?) {
                var requestOptions = requestOptions ?? RequestOptions()
                requestOptions.setParameter(geolocation.stringForm, forKey: .aroundLatLng)
                requestOptions.setParameter(hitsPerPage.flatMap(String.init), forKey: .hitsPerPage)
                requestOptions.setParameter(language?.rawValue, forKey: .aroundLatLng)
                self.requestOptions = requestOptions
                self.path = URL
                    .places
                    .appending(.reverse)
            }
        }
    }
}
