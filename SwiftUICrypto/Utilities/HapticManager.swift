//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/21.
//

import Foundation
import SwiftUI

class HapticManager{
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
