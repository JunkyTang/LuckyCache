//
//  LuckyCache.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/16.
//

import Foundation


public class LuckyCache {
    
    public enum CacheOption: CaseIterable {
        case memory
        case disk
    }
    
    public let diskCache: DiskCache
    public let memoryCache: MemoryCache
    
    
    public init(diskCache: DiskCache = DiskCache(),
                memoryCache: MemoryCache = MemoryCache()) {
        self.diskCache = diskCache
        self.memoryCache = memoryCache
    }
    
    
}

public extension LuckyCache {
    
    func set<T: Cacheable>(obj: T, key: String, validity: CacheEntity.Validity? = nil, option: [CacheOption] = CacheOption.allCases) throws {
        
        let data = try obj.convertToData()
        let entity = CacheEntity(validity: validity, data: data)
        if option.contains(.memory) {
            try memoryCache.setEntity(entity, key: key)
        }
        if option.contains(.disk) {
            try diskCache.setEntity(entity, key: key)
        }
    }
    
    func get<T: Cacheable>(for key: String, option: [CacheOption] = CacheOption.allCases) throws -> T {
        
        if option.contains(.memory) {
            if let entity: CacheEntity = try? memoryCache.entity(for: key) {
                if let validity = entity.validity {
                    if validity.isValid == false {
                        memoryCache.remove(for: key)
                        throw Exception.invalidError
                    }
                }
                return try T.from(data: entity.data)
            }
        }
        
        if option.contains(.disk) {
            if let entity: CacheEntity = try? diskCache.entity(for: key) {
                if let validity = entity.validity {
                    if validity.isValid == false {
                        diskCache.remove(for: key)
                        throw Exception.invalidError
                    }
                }
                if option.contains(.memory) {
                    try? memoryCache.setEntity(entity, key: key)
                }
                return try T.from(data: entity.data)
            }
            
        }
        throw Exception.noFound
    }
    
    func remove(key: String, option: [CacheOption] = CacheOption.allCases) {
        
        if option.contains(.memory) {
            memoryCache.remove(for: key)
        }
        if option.contains(.disk) {
            diskCache.remove(for: key)
        }
    }
    
    
    func removeAll(option: [CacheOption] = CacheOption.allCases) {
        if option.contains(.memory) {
            memoryCache.removeAll()
        }
        if option.contains(.disk) {
            diskCache.removeAll()
        }
    }
}
