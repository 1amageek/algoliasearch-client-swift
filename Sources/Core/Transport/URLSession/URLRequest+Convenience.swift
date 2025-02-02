//
//  URLRequest+Convenience.swift
//  
//
//  Created by Vladislav Fitc on 02/03/2020.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLRequest: Builder {}

extension CharacterSet {
    
    // Allowed characters taken from [RFC 3986](https://tools.ietf.org/html/rfc3986) (cf. §2 "Characters"):
    // - unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
    // - gen-delims  = ":" / "/" / "?" / "#" / "[" / "]" / "@"
    // - sub-delims  = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="
    //
    // ... with these further restrictions:
    // - ampersand ('&') and equal sign ('=') removed because they are used as delimiters for the parameters;
    // - question mark ('?') and hash ('#') removed because they mark the beginning and the end of the query string.
    // - plus ('+') is removed because it is interpreted as a space by Algolia's servers.
    //
    public static let urlParameterAllowed: CharacterSet = .alphanumerics.union(.init(charactersIn: "-._~:/[]@!$'()*,;"))
    
    public static let urlPathComponentAllowed: CharacterSet = {
        var characterSet = CharacterSet()
        characterSet.formUnion(CharacterSet.urlPathAllowed)
        characterSet.remove(charactersIn: "/")
        return characterSet
    }()
    
}

extension URLRequest {
    
    subscript(header key: HTTPHeaderKey) -> String? {
        
        get {
            return allHTTPHeaderFields?[key.rawValue]
        }
        
        set(newValue) {
            setValue(newValue, forHTTPHeaderField: key.rawValue)
        }
        
    }
    
    public init(command: AlgoliaCommand) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.percentEncodedPath = command.path.path
        if let urlParameters = command.requestOptions?.urlParameters {
            urlComponents.queryItems = urlParameters.map { (key, value) in .init(name: key.rawValue, value: value) }
        }
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = command.method.rawValue
        request.httpBody = command.body
        
        if let requestOptions = command.requestOptions {
            
            requestOptions.headers.forEach { header in
                let (value, field) = (header.value, header.key.rawValue)
                request.setValue(value, forHTTPHeaderField: field)
            }
            
            // If body is set in query parameters, it will override the body passed as parameter to this function
            if let body = requestOptions.body, !body.isEmpty {
                let jsonEncodedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonEncodedBody
            }
            
        }
        request.httpBody = command.body
        self = request
    }
    
}

extension URLRequest {
    
    var credentials: Credentials? {
        
        get {
            guard let appID = applicationID, let apiKey = apiKey else {
                return nil
            }
            return AlgoliaCredentials(applicationID: appID, apiKey: apiKey)
        }
        
        set {
            guard let newValue = newValue else {
                applicationID = nil
                apiKey = nil
                return
            }
            applicationID = newValue.applicationID
            apiKey = newValue.apiKey
        }
        
    }
    
    var applicationID: ApplicationID? {
        
        get {
            return self[header: .applicationID].flatMap(ApplicationID.init)
        }
        
        set {
            self[header: .applicationID] = newValue?.rawValue
        }
    }
    
    var apiKey: APIKey? {
        
        get {
            return self[header: .apiKey].flatMap(APIKey.init)
        }
        
        set {
            do {
                try setAPIKey(newValue)
            } catch let error {
                Logger.error("Couldn't set API key in the request body due to error: \(error)")
            }
        }
        
    }
    
}
