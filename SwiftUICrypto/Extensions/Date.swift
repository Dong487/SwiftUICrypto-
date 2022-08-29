//
//  Date.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/26.
//

import Foundation

extension Date{
    
    // "2021-04-14T11:54:46.763Z"
    init(coinGeckoString: String){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    // 轉成 short 日期格式
    private var shortFormatter: DateFormatter{
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    // 將 short 日期 轉成 Srting 型態
    func asShortDateString() -> String{
        return shortFormatter.string(from: self)
    }
}
