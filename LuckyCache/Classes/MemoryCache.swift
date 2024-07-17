//
//  MemoryCache.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation


public class MemoryCache {
    
    private let cache = NSCache<NSString, NSData>()
    
    private var config: MemoryCacheConfig
    
    public init(config: MemoryCacheConfig = MemoryCacheConfig()) {
        self.config = config
        cache.countLimit = config.maxCount
        cache.totalCostLimit = config.totalSize
    }
}


extension MemoryCache: CacheType {
    
    
    public func set(obj: Data, key: String) {
        let cost = obj.count
        cache.setObject(obj as NSData, forKey: key as NSString, cost: cost)
    }
    
    public func object(for key: String) -> Data? {
        return cache.object(forKey: key as NSString) as? Data
    }
    
    public func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    public func removeAll() {
        cache.removeAllObjects()
    }
    
}
