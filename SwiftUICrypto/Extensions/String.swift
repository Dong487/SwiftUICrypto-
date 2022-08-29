//
//  String.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/26.
//

import Foundation

extension String{
    
    // 用來刪硬幣資訊中 多餘的html
    var removingHTMLOccurances: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
