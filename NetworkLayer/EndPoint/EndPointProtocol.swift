//
//  EndPointProtocol.swift
//  Library
//
//  Created by Даниил Смирнов on 04.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
	
	var baseUrl: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var task: HTTPTask { get }
	var headers: HTTPHeaders? { get }
}
