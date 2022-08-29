//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/15.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    //123123
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
