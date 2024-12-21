//
//  Double.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation

extension Double {
    
    /// Converts a double into a Currency with 2 decimal places
    /// ```
    /// Convert 12345.56 to $1,234.56
    /// ```
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    /// Converts a double into a Currency as a string with 2 to 6 decimal places
    /// ```
    /// Convert 12345.56 to "$1,234.56"
    /// ```
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    /// Converts a double into a Currency with 2 to 6 decimal places
    /// ```
    /// Convert 12345.56 to $1,234.56
    /// Convert 12.34556 to $12.3456
    /// Convert 0.12345.56 to $0.1234.56
    /// ```
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    /// Converts a double into a Currency as a string with 2 to 6 decimal places
    /// ```
    /// Convert 12345.56 to "$1,234.56"
    /// Convert 12.34556 to "$12.3456"
    /// Convert 0.12345.56 to "$0.1234.56"
    /// ```
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a String representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a double into a String representation with percent symbol
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    
    func asPrecentString() -> String {
        return asNumberString() + "%"
    }
}
