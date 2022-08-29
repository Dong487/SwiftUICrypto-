//
//  CoinModel.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/12.
//

import Foundation

// command + option + 向左 折疊

//加幣貨幣 API
/* URL:https://api.coingecko.com/api/v3/coins/markets?vs_currency=ntd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
    幣值: TWD
    
 
   {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 1235022,
     "market_cap": 23284489585590,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 26031667208217,
     "total_volume": 1047746482892,
     "high_24h": 1300031,
     "low_24h": 1239603,
     "price_change_24h": -43315.04372576857,
     "price_change_percentage_24h": -3.38839,
     "market_cap_change_24h": -689221361966.1719,
     "market_cap_change_percentage_24h": -2.8749,
     "circulating_supply": 18783825,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 1844031,
     "ath_change_percentage": -32.35066,
     "ath_date": "2021-04-14T11:54:46.763Z",
     "atl": 1998.66,
     "atl_change_percentage": 62315.71466,
     "atl_date": "2013-07-05T00:00:00.000Z",
     "roi": null,
     "last_updated": "2021-08-12T12:33:07.742Z",
     "sparkline_in_7d": {
       "price": [
         38097.24009234376,
         37595.74682436388
    
       ]
     },
     "price_change_percentage_24h_in_currency": -3.388388717526743
   }
*/


struct CoinModel: Identifiable, Codable{
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    
    // 用戶持有多少貨幣
    let currentHoldings: Double?
    
    
    
    // 解析JSON 給予相對應的名稱(有些跟Json檔案的不完全相同)
    enum CodingKeys: String, CodingKey{
        
        case id, symbol, name ,image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        
        case high24H = "high_24h"
        case low24H = "low_24h"
        
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double)-> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
            
            // 更新目前擁有的貨幣(Double)
            currentHoldings: amount)
    }
    
    // 所擁有的總價值
    var currentHoldingsValue: Double{
        
        // 擁有的貨幣數 * 當前的價格 = 總價值  (前面宣告有?   如果系統讀取不到則預設為 0)
        return (currentHoldings ?? 0 ) * currentPrice
    }
    
    
    var rank: Int{
        // 前面 marketCapRank 設為 Double 轉為 Int
        // (前面宣告有?   如果系統讀取不到則預設為 0)
        return Int(marketCapRank ?? 0)
    }
    
}

// MARK: - SparklineIn7D
struct SparklineIn7D : Codable{
    let price: [Double]?
}
