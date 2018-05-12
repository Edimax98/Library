//
//  Router.swift
//  Library
//
//  Created by Даниил Смирнов on 05.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointProtocol>: NetworkRouter {
	private var task: URLSessionTask?
	
	func request(_ route: EndPoint, completion: @escaping NetworkResourseCompletion) {
		
		let session = URLSession.shared
		
		do {
			let request = try self.buildRequest(from: route)
			NetworkLogger.log(request: request)
			task = session.dataTask(with: request, completionHandler: { (data, response, error) in
				completion(data,response,error)
			})
		} catch {
			completion(nil,nil,error)
		}
		self.task?.resume()
	}
	
	func cancel() {
		self.task?.cancel()
	}

	fileprivate func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
		
		do {
			try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
		} catch {
			throw error
		}
	}
	
	fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
		
		var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
								 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
								 timeoutInterval: 10.0)
		
		request.httpMethod = route.method.rawValue
		
		do {
			switch route.task {
			case .request:
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
				try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
			}
		} catch {
			throw error
		}
		
		return request
	}
}
