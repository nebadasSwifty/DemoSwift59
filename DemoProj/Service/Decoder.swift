//
//  Decoder.swift
//  DemoProj
//
//  Created by Кирилл Сутормин on 20.06.2023.
//

import Foundation

enum DecoderEncoder {
    static let decoder = JSONDecoder()
    
    static func decode<T: Decodable>(_ data: Data?, by type: T.Type) throws -> T {
        guard let data = data else {
            throw DecoderEncoderError.badJSONData
        }
        
        do {
            let result = try decoder.decode(type, from: data)
            return result
        } catch {
            throw DecoderEncoderError.failureWhenDecodingEncoding
        }
    }
}

fileprivate extension DecoderEncoder {
    enum DecoderEncoderError: Error {
        case badJSONData
        case failureWhenDecodingEncoding
    }
}
