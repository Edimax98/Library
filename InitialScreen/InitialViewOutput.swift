//
//  InitialViewOutput.swift
//  Library
//
//  Created by Даниил Смирнов on 13.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

protocol InitialViewOutput: class {
	
	func clientLoggedIn(as user: User)
}
