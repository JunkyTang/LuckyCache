//
//  DataConvertible.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/16.
//

import Foundation


public protocol DataConvertible {
    
    func convertToData() throws -> Data
    
    static func from(data: Data) throws -> Self
}

public extension DataConvertible where Self: Codable {
    
    
    func convertToData() throws -> Data {
        let data: Data
        do {
            data = try JSONEncoder().encode(self)
        } catch {
            throw Exception.convertToDataError
        }
        return data
    }
    
    static func from(data: Data) throws -> Self {
        
        let obj: Self
        do {
            obj = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            throw Exception.initializingFromFataError
        }
        return obj
    }
    
}
