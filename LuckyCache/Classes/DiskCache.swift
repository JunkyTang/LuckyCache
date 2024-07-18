//
//  DiskCache.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation


public class DiskCache {
    
    public let config: DiskCacheConfig
    
    public init(config: DiskCacheConfig = DiskCacheConfig()) {
        self.config = config
    }
}

extension DiskCache: CacheType {
    
    public func set(obj: Data, key: String) {
        let fileURL = config.folderUrl.appendingPathComponent(key)
        do {
            try obj.write(to: fileURL)
        } catch {
            print("Failed to write data to disk: \(error.localizedDescription)")
        }
    }
    
    public func object(for key: String) -> Data? {
        let fileURL = config.folderUrl.appendingPathComponent(key)
        return try? Data(contentsOf: fileURL)
    }
    
    public func remove(for key: String) {
        let fileURL = config.folderUrl.appendingPathComponent(key)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to remove data from disk: \(error.localizedDescription)")
        }
    }
    
    public func removeAll() {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: config.folderUrl, includingPropertiesForKeys: nil)
            for file in files {
                try FileManager.default.removeItem(at: file)
            }
        } catch {
            print("Failed to clear cache directory: \(error.localizedDescription)")
        }
    }
    
}
