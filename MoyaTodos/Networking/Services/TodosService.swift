//
//  TodosService.swift
//  MoyaTodos
//
//  Created by Omar on 11/15/18.
//  Copyright © 2018 Teknasyon. All rights reserved.
//

import Foundation
import Moya

enum TodosService<E: EnvironmentType> {

	case create(Todo)
	case getAll
	case getTodo(id: Int)
	case delete(id: Int)

}

// MARK: - TargetType
extension TodosService: TargetType {

	var baseURL: URL {
		return E.baseUrl.appendingPathComponent("todos")
	}

	var path: String {
		switch self {
		case .create,
			 .getAll:
			return ""
		case .getTodo(let id),
			 .delete(let id):
			return "\(id)"
		}
	}

	var method: Moya.Method {
		switch self {
		case .getAll, .getTodo:
			return .get
		case .create:
			return .post
		case .delete:
			return .delete
		}
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
		switch self {
		case .getAll, .getTodo, .delete:
			return .requestPlain
		case .create(let todo):
			return .requestJSONEncodable(todo)
		}
	}

	var headers: [String : String]? {
		return E.baseHeaders
	}


}
