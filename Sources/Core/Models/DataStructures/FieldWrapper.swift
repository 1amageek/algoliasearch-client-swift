//
//  FieldWrapper.swift
//
//
//  Created by Vladislav Fitc on 31/03/2020.
//

import Foundation

public struct FieldWrapper<K: Key, Wrapped: Codable>: Codable {
    
    public let wrapped: Wrapped
    
    public init(_ wrapped: Wrapped) {
        self.wrapped = wrapped
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        self.wrapped = try container.decode(Wrapped.self, forKey: DynamicKey(stringValue: K.value))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicKey.self)
        try container.encode(wrapped, forKey: DynamicKey(stringValue: K.value))
    }
    
}

public protocol Key {
    static var value: String { get }
}

public struct ParamsKey: Key { public static let value = "params" }
public struct RequestsKey: Key { public static let value = "requests" }
public struct EventsKey: Key { public static let value = "events" }
public struct EditsKey: Key { public static let value = "edits" }
public struct ObjectIDKey: Key { public static let value = "objectID" }
public struct RemoveKey: Key { public static let value = "remove" }
public struct ClusterKey: Key { public static let value = "cluster" }
public struct CursorKey: Key { public static let value = "cursor" }

public typealias ParamsWrapper<Wrapped: Codable> = FieldWrapper<ParamsKey, Wrapped>
public typealias RequestsWrapper<Wrapped: Codable> = FieldWrapper<RequestsKey, Wrapped>
public typealias EventsWrapper<Wrapped: Codable> = FieldWrapper<EventsKey, Wrapped>
public typealias EditsWrapper = FieldWrapper<EditsKey, [Rule.Edit]>
public typealias ObjectIDWrapper = FieldWrapper<ObjectIDKey, ObjectID>
public typealias ClusterWrapper<Wrapped: Codable> = FieldWrapper<ClusterKey, Wrapped>
public typealias CursorWrapper = FieldWrapper<CursorKey, Cursor>
