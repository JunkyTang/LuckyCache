//
//  CacheEntity.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/16.
//

import Foundation

public final class CacheEntity: Codable {
    
    public enum Validity: Codable {
        case duration(startDate: Date,duration: TimeInterval)
        case expires(expirationDate: Date)
        
        public var isValid: Bool {
            let now = Date().timeIntervalSince1970
            let timeIntervel: TimeInterval
            switch self {
            case .duration(let startDate, let duration):
                timeIntervel = startDate.timeIntervalSince1970 + duration
            case .expires(let expirationDate):
                timeIntervel = expirationDate.timeIntervalSince1970
            }
            return timeIntervel > now
        }
    }
    
    public let validity: Validity?
    
    public let data: Data
    
    public init(validity: Validity? = nil, data: Data) {
        self.validity = validity
        self.data = data
    }
}


extension CacheEntity: Cacheable {}


