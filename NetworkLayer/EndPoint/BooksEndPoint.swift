//
//  File.swift
//  Library
//
//  Created by Даниил Смирнов on 11.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

enum BooksApi {
	case all
	case signIn(login: String, password: String)
	case signUp(user: User)
	case book(id: Int)
}

extension BooksApi: EndPointProtocol {
	
	var enviromentBaseUrl: String {
		return "http://46.188.5.222/"
	}
	
	var baseUrl: URL {
		guard let url =  URL(string: enviromentBaseUrl) else { fatalError("baseURL could not be configured.") }
		return url
 	}
	
	var path: String {
		switch self {
		case .all:
			return "getbooks"
		case .book(_):
			return "bookItBook"
		case .signIn(_,_):
			return "signin"
		case .signUp(_):
			return "signUp"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .all:
			return .get
		case .book(_):
			return .post
		case .signIn(_, _):
			return .post
		case .signUp(_):
			return .post
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .all:
			return .request
		case .book(let id):
			return .requestParameters(bodyParameters: ["id":id], bodyEncoding: .jsonEncoding, urlParameters: nil)
		case .signIn(let login, let password):
			return .requestParameters(bodyParameters: ["login":login,
													   "password":password], bodyEncoding: .jsonEncoding, urlParameters: nil)
		case .signUp(let user):
			return .requestParameters(bodyParameters: ["user": user], bodyEncoding: .jsonEncoding, urlParameters: nil)
		}
	}
	
	var headers: HTTPHeaders? {
		return nil
	}
}
