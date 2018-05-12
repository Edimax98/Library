//
//  NetworkManager.swift
//  Library
//
//  Created by Даниил Смирнов on 11.05.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
	
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request"
	case outdated = "The url you requested is outdated."
	case failed = "Network request failed."
	case noData = "Response returned with no data to decode."
	case unableToDecode = "We could not decode the response."
}

enum Result<String> {
	case success
	case failure(String)
}

struct NetworkManager {
	
	let router = Router<BooksApi>()
		
	func getAllBooks(completion: @escaping (_ book: [Book]?, _ error: String?)->()){
		router.request(.all) { data, response, error in
			
			if error != nil {
				completion(nil, "Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, NetworkResponse.noData.rawValue)
						return
					}
					do {
						print(responseData)
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
						let apiResponse = try JSONDecoder().decode(BookApiResponse.self, from: responseData)
						completion(apiResponse.books,nil)
					}catch {
						print(error)
						completion(nil, NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(nil, networkFailureError)
				}
			}
		}
	}
	
	func bookBook(with id: Int, completion: @escaping ( _ error: String?)->()) {
		router.request(BooksApi.book(id: id)) { (data, response, error) in
			
			if error != nil {
				completion("Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				
				switch result {
				case .success:
					guard let responseData = data else {
						completion(NetworkResponse.noData.rawValue)
						return
					}
					do {
						print(responseData)
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
						completion(nil)
					}catch {
						print(error)
						completion(NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(networkFailureError)
				}
			}
		}
	}
	
	func signUp(with user: User, completion: @escaping ( _ error: String?)->()) {
		router.request(.signUp(user: user)) { (data, response, error) in
			
			if error != nil {
				completion("Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				
				switch result {
				case .success:
					guard let responseData = data else {
						completion(NetworkResponse.noData.rawValue)
						return
					}
					do {
						print(responseData)
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
					}catch {
						print(error)
						completion(NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(networkFailureError)
				}
			}
		}
	}
	
	func signIn(with login: String, and password: String, completion: @escaping ( _ loginStatus: Bool?,_ message: String?, _ error: String?)->()) {
		router.request(.signIn(login: login, password: password)) { (data, response, error) in
			
			if error != nil {
				completion(nil, nil, "Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, nil, NetworkResponse.noData.rawValue)
						return
					}
					do {
						print(responseData)
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
						let apiResponse = try JSONDecoder().decode(UserApiResponse.self, from: responseData)
						completion(true, apiResponse.message, nil)
					} catch {
						print(error)
						completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(nil, nil, networkFailureError)
				}
			}
		}
	}
	
	
	func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outdated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}
