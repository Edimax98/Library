//
//  URLParameterEncoder.swift
//  Library
//
//  Created by Даниил Смирнов on 04.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

struct URLParameterEncoder {
	
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		
		guard let url = urlRequest.url else { throw NetworkError.missingUrl }
		
		
		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
			
			for (key, value) in parameters {
				
				let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			
			urlRequest.url = urlComponents.url
		}
		
		if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
		}
	}
}
