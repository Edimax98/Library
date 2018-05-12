//
//  NetworkRouter.swift
//  Library
//
//  Created by Даниил Смирнов on 05.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

typealias NetworkResourseCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void

protocol NetworkRouter: class {
	
	associatedtype EndPoint: EndPointProtocol
	
	func request(_ route: EndPoint, completion: @escaping NetworkResourseCompletion)
	func cancel()
}
