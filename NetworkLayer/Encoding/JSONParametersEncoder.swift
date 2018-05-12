//
//  JSONParametersEncoder.swift
//  Library
//
//  Created by Даниил Смирнов on 04.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation


struct JSONParametersEncoder {
	
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		
		do {
			let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .sortedKeys)
			urlRequest.httpBody = jsonAsData
			
			if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			}
		} catch {
			throw NetworkError.encodingFailed
		}
	}
}
