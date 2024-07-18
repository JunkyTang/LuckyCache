//
//  CacheConfig.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation


public struct DiskCacheConfig {
    
    public let directory: URL
    
    public let folder: String
    
    public let maxCount: UInt?
    
    public let totalSize: UInt?
    
    public let folderUrl: URL
    
    public init(directory: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0],
         folder: String = "com.lucky.cache",
         maxCount: UInt? = nil,
         totalSize: UInt? = nil) {
        self.directory = directory
        self.folder = folder
        self.maxCount = maxCount
        self.totalSize = totalSize
        self.folderUrl = directory.appendingPathComponent(folder)
        
        createFolder()
    }
    
    public func createFolder() {
        do {
            try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true)
        } catch {
            print("Create folder error: \(error)")
        }
    }

}

public struct MemoryCacheConfig {
    
    public private(set) var maxCount: Int
    
    public private(set) var totalSize: Int
    
    public init(maxCount: Int = 0,
         totalSize: Int = 0) {
        self.maxCount = maxCount
        self.totalSize = totalSize
    }
}
