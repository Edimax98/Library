//
//  SearchBookViewOutput.swift
//  Library
//
//  Created by Даниил Смирнов on 21.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

protocol SearchBookViewOutput: class {
	
	func bookWasSearched(with indexPath: Int)
}
