//
//  TestEnv.swift
//  MoyaTodos
//
//  Created by Omar on 11/15/18.
//  Copyright © 2018 Teknasyon. All rights reserved.
//

import Foundation

struct TestEnv: EnvironmentType {

	static var baseUrl: URL {
		return URL(string: "https://jsonplaceholder.typicode.com")!
	}

}
