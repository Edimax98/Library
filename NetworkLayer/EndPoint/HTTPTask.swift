//
//  HTTPTask.swift
//  Library
//
//  Created by Даниил Смирнов on 04.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
	case request
	case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
}
