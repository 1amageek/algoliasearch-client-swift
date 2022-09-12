//
//  ClientDateCodingStrategy.swift
//  
//
//  Created by Vladislav Fitc on 06/04/2020.
//

import Foundation

struct ClientDateCodingStrategy {
    
    private static let acceptedFormats = [
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    ]
    
    static func decoding(decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        if let unixTimeStamp = try? container.decode(TimeInterval.self) {
            return Date(timeIntervalSince1970: unixTimeStamp)
        }
        let stringValue = try container.decode(String.self)
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        for format in acceptedFormats {
            formatter.dateFormat = format
            if let date = formatter.date(from: stringValue) {
                return date
            }
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string doesnt conform to iso8601 standart")
    }
    
    static let encoding: (Date, Encoder) throws -> Void = { date, encoder in
        var container = encoder.singleValueContainer()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = formatter.string(from: date)
        try container.encode(dateString)
    }
    
}

extension JSONDecoder.DateDecodingStrategy {
    static let swiftAPIClient = JSONDecoder.DateDecodingStrategy.custom(ClientDateCodingStrategy.decoding)
}

extension JSONEncoder.DateEncodingStrategy {
    static let swiftAPIClient = JSONEncoder.DateEncodingStrategy.custom(ClientDateCodingStrategy.encoding)
}
