//
//  MarketDataModel.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/17.
//

import Foundation
// command + option + 向左 折疊


// JSON Data:
/*
 
    URL: https://api.coingecko.com/api/v3/global

 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 8939,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 635,
     "total_market_cap": {
       "btc": 44513384.37953976,
       "eth": 641544729.0650643,
       "ltc": 11487760051.037457,
       "bch": 3039660909.779808,
       "bnb": 4850893414.60242,
       "eos": 377826393417.0107,
       "xrp": 1735153255561.4087,
       "xlm": 5544315866197.189,
       "link": 71130870846.03537,
       "dot": 80136468748.04874,
       "yfi": 50848651.44138302,
       "usd": 2066480044312.8208,
       "aed": 7590160537960.541,
       "ars": 200930260796673,
       "aud": 2841777894378.0186,
       "bdt": 175540988950554.9,
       "bhd": 779069176146.0656,
       "bmd": 2066480044312.8208,
       "brl": 10938705466565.484,
       "cad": 2607957743844.0684,
       "chf": 1884336360247.0015,
       "clp": 1634523720650114.5,
       "cny": 13400296495350.93,
       "czk": 44839517241521.6,
       "dkk": 13092899322839.21,
       "eur": 1760585202793.3281,
       "gbp": 1501512666117.8735,
       "hkd": 16104942773988.357,
       "huf": 618209465739613.1,
       "idr": 29761144658770880,
       "ils": 6677879858717.948,
       "inr": 153694145390239.53,
       "jpy": 226307314724182.7,
       "krw": 2430307909941809.5,
       "kwd": 621657125250.5809,
       "lkr": 412296138360163.3,
       "mmk": 3401708529171037.5,
       "mxn": 41276802321124.234,
       "myr": 8757742427797.757,
       "ngn": 850769834243588.4,
       "nok": 18313735099512.85,
       "nzd": 2991300124464.3174,
       "php": 104264250635803.47,
       "pkr": 339994339151271,
       "pln": 8031748725109.801,
       "rub": 151883183536925.88,
       "sar": 7749882913545.593,
       "sek": 17951900643193.8,
       "sgd": 2812783112876.265,
       "thb": 68786423213350.34,
       "try": 17412437761705.773,
       "twd": 57649627036217.04,
       "uah": 55093666063247.766,
       "vef": 206916646837.04297,
       "vnd": 47320003496359210,
       "zar": 30791484642761.043,
       "xdr": 1451999804256.1377,
       "xag": 87022016436.46722,
       "xau": 1155926942.3872623,
       "bits": 44513384379539.76,
       "sats": 4451338437953976
     },
     "total_volume": {
       "btc": 3169832.3628993738,
       "eth": 45684893.94332989,
       "ltc": 818052235.177576,
       "bch": 216456592.96328282,
       "bnb": 345435853.70807934,
       "eos": 26905308282.09235,
       "xrp": 123561598847.93799,
       "xlm": 394815000202.1939,
       "link": 5065284061.227558,
       "dot": 5706579619.293049,
       "yfi": 3620971.6065258733,
       "usd": 147155634491.7991,
       "aed": 540501173932.03265,
       "ars": 14308398524104.553,
       "aud": 202365191129.16342,
       "bdt": 12500408934230.39,
       "bhd": 55478115670.31167,
       "bmd": 147155634491.7991,
       "brl": 778953635618.8892,
       "cad": 185714678242.05093,
       "chf": 134185042556.42302,
       "clp": 116395692213978.52,
       "cny": 954245427425.5212,
       "czk": 3193056535020.2925,
       "dkk": 932355438172.3274,
       "eur": 125372627384.88162,
       "gbp": 106923872644.27924,
       "hkd": 1146845370649.8096,
       "huf": 44023171881149.58,
       "idr": 2119314017822995.5,
       "ils": 475536964595.47687,
       "inr": 10944678389138.023,
       "jpy": 16115518066590.68,
       "krw": 173064096835665.88,
       "kwd": 44268682368.53338,
       "lkr": 29359925350299.69,
       "mmk": 242238282602332.03,
       "mxn": 2939352863374.7173,
       "myr": 623645578976.2461,
       "ngn": 60583974720273.69,
       "nok": 1304135172222.1538,
       "nzd": 213012784218.45206,
       "php": 7424737538283.7295,
       "pkr": 24211258579108.457,
       "pln": 571947008622.2203,
       "rub": 10815718401695.496,
       "sar": 551875127233.1746,
       "sek": 1278368662089.5427,
       "sgd": 200300450421.60898,
       "thb": 4898334140820.614,
       "try": 1239953095082.9214,
       "twd": 4105274313234.973,
       "uah": 3923262365067.9907,
       "vef": 14734693681.663858,
       "vnd": 3369693870417449,
       "zar": 2192685321118.964,
       "xdr": 103398023641.85568,
       "xag": 6196904769.880073,
       "xau": 82314447.26567765,
       "bits": 3169832362899.3735,
       "sats": 316983236289937.4
     },
     "market_cap_percentage": {
       "btc": 42.20959215277323,
       "eth": 18.256055451941414,
       "ada": 3.1973132506369706,
       "bnb": 3.1850664193510596,
       "usdt": 3.079993272635515,
       "xrp": 2.6749217090711834,
       "doge": 2.0558421524333683,
       "usdc": 1.320324122632664,
       "dot": 1.275241264191305,
       "sol": 0.9437623165290189
     },
     "market_cap_change_percentage_24h_usd": -1.5200072666434394,
     "updated_at": 1629206603
   }
 }
 */


struct GlobalData: Codable{
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {

    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey{
        
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String{
/*
        if let item = totalMarketCap.first(where: { (key ,value) -> Bool in
            return key == "twd"  // 台幣
        }){
            return "\(item.value)"
        }
*/
        // marketCap較簡略的寫法 (跟上面程式碼一樣功能) 123123
        
        if let item = totalMarketCap.first(where: { $0.key == "twd"}){
            return "NT$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String{
        if let item = totalVolume.first(where: { $0.key == "twd"}){
            return "NT$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}){
            return item.value.asPercentString()  // 回傳是 Double 百分比
        }
        return ""
    }
}
