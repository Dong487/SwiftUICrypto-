//
//  Color.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/12.
//

import Foundation
import SwiftUI

extension Color{
    
    //靜態
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryColor")
}


struct LaunchTheme{
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
