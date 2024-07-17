//
//  Cacheable.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/15.
//

import Foundation

public protocol Cacheable: DataConvertible{}

extension UIImage: Cacheable {
    public func convertToData() throws -> Data {
        guard let data = pngData()
        else { throw Exception.convertToDataError }
        return data
    }
    
    public static func from(data: Data) throws -> Self {
        guard let image = UIImage(data: data)
        else { throw Exception.initializingFromFataError }
        return image as! Self
    }
}
