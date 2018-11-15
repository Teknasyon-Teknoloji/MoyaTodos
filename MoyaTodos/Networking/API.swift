//
//  API.swift
//  MoyaTodos
//
//  Created by Omar on 11/15/18.
//  Copyright © 2018 Teknasyon. All rights reserved.
//

import Moya

final class API: APIType {

	typealias Environment = TestEnv

	static var todosProvider = MoyaProvider<TodosService<Environment>>()

}

