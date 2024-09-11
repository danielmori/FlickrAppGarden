//
//  StringExtensions.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import Foundation

extension String {
    var numericValue: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    var alphanumerical: String {
        let validCharacters = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890.!_+-=")
        return self.filter { validCharacters.contains($0) }
    }
}
