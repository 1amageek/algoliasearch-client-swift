//
//  AlgoliaCommandTest.swift
//  
//
//  Created by Vladislav Fitc on 26/03/2020.
//

import Foundation
import XCTest
@testable import AlgoliaSearchClient
@testable import Core
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol AlgoliaCommandTest {

  var test: TestValues { get }
  func check<Command: AlgoliaCommand>(command: Command, callType: CallType, method: HTTPMethod, urlPath: String, queryItems: Set<URLQueryItem>, body: Data?, additionalHeaders: [HTTPHeaderKey: String]?, requestOptions: RequestOptions, file: StaticString, line: UInt)

}

extension AlgoliaCommandTest {

  var test: TestValues {
    return TestValues()
  }

  func check<Command: AlgoliaCommand>(command: Command, callType: CallType, method: HTTPMethod, urlPath: String, queryItems: Set<URLQueryItem>, body: Data?, additionalHeaders: [HTTPHeaderKey: String]? = nil, requestOptions: RequestOptions, file: StaticString = #file, line: UInt = #line) {
    
    let request = URLRequest(command: command)
    XCTAssertEqual(command.callType, callType, file: file, line: line)
    XCTAssertEqual(request.httpMethod, method.rawValue, file: file, line: line)
    XCTAssertEqual(request.url?.path, urlPath, file: file, line: line)
    
    let requestQueryItems = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)?.queryItems ?? []

    #if canImport(FoundationNetworking)
    XCTAssertEqual(request.allHTTPHeaderFields?.mapKeys { $0.lowercased() }, requestOptions.headers.merging(additionalHeaders ?? [:]).mapKeys { $0.rawValue.lowercased() }, file: file, line: line)
    
    for item in requestQueryItems {
      XCTAssertTrue(queryItems.contains(where: { $0.name == item.name && $0.value == item.value }) , file: file, line: line)
    }

      let dateFormatter = DateFormatter()
      dateFormatter.calendar = Calendar(identifier: .gregorian)
      dateFormatter.timeZone = TimeZone.current
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

      let jsonDecoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(dateFormatter)

    func dataToJSON(_ data: Data) throws -> JSON { try jsonDecoder.decode(JSON.self, from: data) }
    try XCTAssertEqual(request.httpBody.flatMap(dataToJSON), body.flatMap(dataToJSON), file: file, line: line)
    #else
    XCTAssertEqual(request.allHTTPHeaderFields, requestOptions.headers.merging(additionalHeaders ?? [:]).mapKeys { $0.rawValue }, file: file, line: line)
    XCTAssertEqual(Set(requestQueryItems), queryItems, file: file, line: line)
    XCTAssertEqual(request.httpBody, body, "Compare with assertEqual", file: file, line: line)
    #endif
  }

}
