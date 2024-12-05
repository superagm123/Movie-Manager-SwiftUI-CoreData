//
//  String+Extension.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
