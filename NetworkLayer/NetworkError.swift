//
//  NetworkError.swift
//  Library
//
//  Created by Даниил Смирнов on 04.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
	
	case parametersNil = "Parameters are nil"
	case encodingFailed = "Parameter encoding failed"
	case missingUrl = "URL is nil"
}
