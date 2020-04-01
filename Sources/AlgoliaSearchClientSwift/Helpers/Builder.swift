//
//  Builder.swift
//  
//
//  Created by Vladislav Fitc on 31/03/2020.
//

import Foundation

protocol Builder {}

extension Builder {
  func set<T>(_ keyPath: WritableKeyPath<Self, T>, to newValue: T) -> Self {
    var copy = self
    copy[keyPath: keyPath] = newValue
    return copy
  }
}
