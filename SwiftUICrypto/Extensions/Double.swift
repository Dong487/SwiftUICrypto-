//
//  Double.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/13.
//

// String 顯示 在 Text 比較方面

import Foundation


extension Double{
    
    /// 格式化一個 Double 的貨幣  顯示小數後 2 位 (Double)
    ///  實際轉換    範例
    ///```
    /// Ex: 1234.56 -> $1,234.56
    ///```
    ///
    private var currencyFormatter2: NumberFormatter{
        
        let formatter = NumberFormatter()
        
        
        formatter.usesGroupingSeparator = true  // 逗號
        formatter.numberStyle = .currency       // Style 貨幣
        formatter.locale = .current             // 語言  當前 (系統默認 預設)
        formatter.currencyCode = "twd"
        formatter.currencySymbol = "$"
        
        formatter.minimumFractionDigits = 2     // 小數 最小 2 位數
        formatter.maximumFractionDigits = 2     //      最大 2 位數
        return formatter
    }
    
    
    /// 格式化一個 Double 的貨幣  顯示小數後 2位 (字串String)
    ///  實際轉換    範例
    ///```
    /// Ex: 1234.56 -> "$1,234.56"
    ///```
    ///
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        
        // 如果讀取不到 則給顯示$0.00
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// 格式化一個 Double 的貨幣  顯示小數後 2-6 位 (Double)
    ///  實際轉換    範例
    ///```
    /// Ex: 1234.56 -> $1,234.56
    /// Ex: 12.3456 -> $12.3456
    /// Ex: 0.123456 -> $0.123456
    ///```
    ///
    private var currencyFormatter6: NumberFormatter{
        
        let formatter = NumberFormatter()
        
        
        formatter.usesGroupingSeparator = true  // 逗號
        formatter.numberStyle = .currency       // Style 貨幣
        formatter.locale = .current             // 語言  當前 (系統默認 預設)
        formatter.currencyCode = "twd"
        formatter.currencySymbol = "$"
        
        formatter.minimumFractionDigits = 2     // 小數 最小 2 位數
        formatter.maximumFractionDigits = 6     //      最大 6 位數
        return formatter
    }
    
    
    /// 格式化一個 Double 的貨幣  顯示小數後 2-6 位 (字串String)
    ///  實際轉換    範例
    ///```
    /// Ex: 1234.56 -> "$1,234.56"
    /// Ex: 12.3456 -> "$12.3456"
    /// Ex: 0.123456 -> "$0.123456"
    ///```
    ///
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        
        // 如果讀取不到 則給顯示$0.00
        return currencyFormatter6.string(from: number) ?? "$0.00"   
    }
    
    
    ///  只顯示到小數後 2 位
    ///  實際轉換    範例
    ///```
    /// Ex: 12.345678 -> "12.34"
    ///
    ///```
    func asNumberString() -> String{
        
        return String(format: "%.2f", self)
    }
    
    
    ///  只顯示到小數後 2 位  並 加上一個 "%" 的符號
    ///  實際轉換    範例
    ///```
    /// Ex: 12.345678 -> "12.34%"
    ///
    ///```
    func asPercentString () -> String {
        return asNumberString() + "%"
    }
    
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

}
