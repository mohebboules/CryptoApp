//
//  String.swift
//  CryptoApp
//
//  Created by Moheb Boules on 23/12/2024.
//

import Foundation

extension String {
    var removingHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
