//
//  User.swift
//  Library
//
//  Created by Даниил Смирнов on 10.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

struct UserApiResponse {
	let loginStatus: Bool
	let registrationStatus: Bool
	let message: String
}

extension UserApiResponse: Decodable {
	
	private enum UserApiResponseCodingKeys: String, CodingKey {
		case loginStatus = "status"
		case message = "msg"
		case registrationStatus = "regStatus"
	}
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: UserApiResponseCodingKeys.self)
		
		loginStatus = try container.decode(Bool.self, forKey: .loginStatus)
		registrationStatus = try container.decode(Bool.self, forKey: .registrationStatus)
		message = try container.decode(String.self, forKey: .message)
	}
}

struct User {
	
	 var name = ""
	 var surname = ""
	 var patronymic = ""
	 var passportNumber = ""
	 var phone = ""
	 var email = ""
	 var password = ""
	 var position: Position = .client
	
	enum Position: Int {
		case admin
		case librarian
		case client
	}
}

extension User: Decodable {
	
	enum UserCodingKeys: String, CodingKey {
		
		case name
		case surname
		case patronymic
		case passportNumber
		case phone
		case email
		case password
	}
	
	init(from decoder: Decoder) throws {
		let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
		
		name = try userContainer.decode(String.self, forKey: .name)
		surname = try userContainer.decode(String.self, forKey: .surname)
		patronymic = try userContainer.decode(String.self, forKey: .patronymic)
		passportNumber = try userContainer.decode(String.self, forKey: .passportNumber)
		phone = try userContainer.decode(String.self, forKey: .phone)
		email = try userContainer.decode(String.self, forKey: .email)
		password = try userContainer.decode(String.self, forKey: .password)
	}
}







