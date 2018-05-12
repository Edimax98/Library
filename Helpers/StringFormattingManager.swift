//
//  StringFormattingManager.swift
//  Library
//
//  Created by Даниил Смирнов on 13.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

struct StringFormattingManager {

	static func deleteSpacesBeforeAndAfter(sentence: String) -> String {
		return sentence.trimmingCharacters(in: .whitespacesAndNewlines)
	}
		
}
