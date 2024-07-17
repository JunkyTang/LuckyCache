//
//  CacheType.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation

public protocol CacheType {
    
    func set(obj: Data, key: String)
    
    func object(for key: String) -> Data?
    
    func remove(for key: String)
    
    func removeAll()
    
}

public extension CacheType {
    
    func setEntity<T: Cacheable>(_ entity: T, key: String) throws {
        
        let data = try entity.convertToData()
        set(obj: data, key: key)
    }
    
    func entity<T: Cacheable>(for key: String) throws -> T {
        
        guard let data = object(for: key)
        else { throw Exception.noFound }
        return try T.from(data: data)
    }
    
}
