//
//  Book.swift
//  Library
//
//  Created by Даниил Смирнов on 14.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

struct BookApiResponse {
	let books: [Book]
}

extension BookApiResponse: Decodable {

	private enum BookApiResponseCodingKeys: String, CodingKey {
		case books = "result"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: BookApiResponseCodingKeys.self)
	
		books = try container.decode([Book].self, forKey: .books)
	}
}

struct Book {
	var id = 0
	var name = ""
	var author = ""
	var publishingOffice = ""
	var year = ""
	var subject = ""
	var carrier = ""
	var volume = 0
	var cover = ""
	var status: Status = .forExtradition
	
	enum Status: Int {
		case forExtradition
		case unavailable
		case forInternalUse
		case booked
	}
}

extension Book: Decodable {
	
	enum BookCodingKeys: String, CodingKey {
		case id = "bid"
		case name = "title"
		case author
		case publishingOffice = "publishing_house"
		case year
		case subject
		case carrier
		case volume
		case cover
		case status
	}
	
	init(from decoder: Decoder) throws {
		let bookContainer = try decoder.container(keyedBy: BookCodingKeys.self)
		
		id = try bookContainer.decode(Int.self, forKey: .id)
		name = try bookContainer.decode(String.self, forKey: .name)
		author = try bookContainer.decode(String.self, forKey: .author)
		publishingOffice = try bookContainer.decode(String.self, forKey: .publishingOffice)
		year = try bookContainer.decode(String.self, forKey: .year)
		subject = try bookContainer.decode(String.self, forKey: .subject)
		carrier = try bookContainer.decode(String.self, forKey: .carrier)
		volume = try bookContainer.decode(Int.self, forKey: .volume)
		cover = try bookContainer.decode(String.self, forKey: .cover)
	}
}









