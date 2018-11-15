//
//  EnvironmentType.swift
//  MoyaTodos
//
//  Created by Omar on 11/15/18.
//  Copyright © 2018 Teknasyon. All rights reserved.
//

import Foundation

protocol EnvironmentType {

	static var baseUrl: URL { get }

}

extension EnvironmentType {

	static var baseHeaders: [String: String] {
		return ["Content-Type": "application/json"]
	}

}
