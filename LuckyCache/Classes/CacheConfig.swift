//
//  CacheConfig.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation


public struct DiskCacheConfig {
    
    private(set) var directory: URL
    
    private(set) var folder: String
    
    private(set) var maxCount: UInt?
    
    private(set) var totalSize: UInt?
    
    private(set) var folderUrl: URL
    
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
    
    private(set) var maxCount: Int
    
    private(set) var totalSize: Int
    
    public init(maxCount: Int = 0,
         totalSize: Int = 0) {
        self.maxCount = maxCount
        self.totalSize = totalSize
    }
}
