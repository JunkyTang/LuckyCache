//
//  Exception.swift
//  LuckyCache
//
//  Created by Lucky on 2024/7/16.
//

import Foundation

enum Exception: Error {
    
    case noFound
    case initializingFromFataError
    case convertToDataError
    case invalidError
}
