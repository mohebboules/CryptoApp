//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
