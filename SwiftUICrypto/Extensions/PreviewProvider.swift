//
//  PreviewProvider.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/13.
//

// 正在創建時 先給的假數值 後面再改成 要使用的數據
// 預覽視窗 的Model 給變量可以直接呼叫 dev.coin 不用每次都重複輸入數值
import Foundation
import SwiftUI

extension PreviewProvider{
    
    static var dev : DeveloperPreview{
        
        return DeveloperPreview.instance
    }
}


class DeveloperPreview{
    
    static let instance = DeveloperPreview()
    
    // 用 private初始化  讓其他地方不會動到
    private init(){
         
        
    }
    
    let homeVM = HomeViewModel()    //123123
    
    // statisticView 用
    let stat1 = StatisticModel(title: "Market Cap ", value: "$ 100.5n", percentageChange: 9.87)
    let stat2 = StatisticModel(title: "Total Volume", value: "$ 1.23Tr")
    let stat3 = StatisticModel(title: "Portfolio Value", value: "$ 50.4k", percentageChange: -12.87)
    
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 1235022,
        marketCap: 23284489585590,
        marketCapRank: 1,
        fullyDilutedValuation: 26031667208217,
        totalVolume: 1047746482892,
        high24H: 1300031,
        low24H: 1239603,
        priceChange24H: -43315.04372576857,
        priceChangePercentage24H: -3.38839,
        marketCapChange24H: -689221361966.1719,
        marketCapChangePercentage24H: -2.8749,
        circulatingSupply: 18783825,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 1844031,
        athChangePercentage: -32.35066,
        athDate: "2021-04-14T11:54:46.763Z",
        atl: 1998.66,
        atlChangePercentage: 62315.71466,
        atlDate: "2013-07-05T00:00:00.000Z",
        lastUpdated: "2021-08-12T12:33:07.742Z",
        sparklineIn7D: SparklineIn7D(
          price: [
            38097.24009234376,
            37595.74682436388,
            37964.91150820191,
            39028.84376674017,
            38824.02351506793,
            39464.54104250195,
            40580.98237542944,
            40923.46578710913,
            40663.25049633999,
            40952.35080975313,
            40844.89380017341,
            40927.23410607631,
            40825.381940449704,
            39871.57156095284,
            40652.49991439878,
            40339.04352853331,
            40126.3037557355,
            40090.91071471639,
            40665.275786599064,
            40959.42840081205,
            40926.654950362456,
            41135.48184151653,
            40665.774751153214,
            40763.03671597905,
            40506.12826285925,
            40708.265022350686,
            40915.40890292245,
            40846.92296591157,
            41914.170872922055,
            42343.482701375346,
            43133.3284880023,
            42777.669116615296,
            42859.35434784507,
            42695.32920921706,
            42468.240196343,
            42667.0899571873,
            42813.24773681491,
            43013.854463891876,
            43274.290894695165,
            43167.27859341427,
            43739.809987252665,
            43306.743254319044,
            43582.4177244287,
            43234.98407094415,
            43348.688977145626,
            43449.37257838608,
            43759.127003012094,
            43670.24442049261,
            43774.68377338093,
            43521.672901069534,
            43346.93049474344,
            43530.75270529045,
            43470.72699734159,
            44114.342503586355,
            43454.83973219603,
            43620.778436638604,
            43566.32187772424,
            43949.12831380084,
            43989.4697118426,
            43979.13920837698,
            44514.60551475258,
            44401.594108879035,
            44035.635601127375,
            44022.77395060531,
            44314.01082110188,
            44236.22109798704,
            44842.52004600221,
            45157.582575934204,
            44863.978956586136,
            44627.81968099991,
            44627.81968099991,
            44627.81968099991,
            44687.641873466295,
            44351.77618113693,
            44508.75716082281,
            44985.65485102847,
            44669.95477332531,
            43939.067824170445,
            44099.92016685909,
            43688.80033456925,
            43881.315461922284,
            43704.07122312769,
            43572.94670643278,
            43774.50094807867,
            44203.02713871914,
            44396.813230027634,
            43753.217862646314,
            43054.692312272724,
            43224.41517649429,
            43461.963738751976,
            43567.532006748734,
            43594.87300315012,
            43520.98695736736,
            43622.11585208131,
            43717.721065084625,
            43843.38957066861,
            44973.65647700485,
            45671.3941534606,
            45779.41679064783,
            45688.224685325935,
            45657.075219039485,
            45553.30120812678,
            45960.39859842436,
            45801.14159401403,
            45881.33587024186,
            46433.42557586405,
            46059.53370383755,
            45698.790715796036,
            45866.94631236485,
            46207.8293519587,
            46311.00189857689,
            45777.11491839463,
            46047.07136816584,
            46090.717216479046,
            45753.41716896474,
            45563.437084408535,
            45634.0091382977,
            45639.420550569026,
            45911.3245691641,
            46090.46847409264,
            45969.08041168147,
            45498.00891054116,
            45387.09171768338,
            45809.13984694519,
            45429.16500985093,
            45314.75762723131,
            45174.67312599897,
            44815.458640886216,
            45081.26243424429,
            45311.53786654732,
            45519.0765317353,
            45672.17087113821,
            45747.81831684451,
            45507.30299788494,
            45628.13626124723,
            45733.64080289466,
            45752.26039975938,
            45297.28037032422,
            45611.997752945004,
            45662.48369901756,
            45883.95947034888,
            46070.67300098137,
            46262.75649295483,
            46136.36990100343,
            46170.721917375275,
            46075.57257763524,
            45889.313342171175,
            45991.760934245685,
            46298.96550251331,
            46585.94039025572,
            46423.34878979837,
            46273.47861476621,
            46449.17205860088,
            46302.0475119017,
            46361.91072059915,
            46368.33703662469,
            46349.5395368855,
            45715.17523266981,
            45656.02527254201,
            45709.63001235903,
            45962.08892219549,
            46165.28651704363,
            46021.20386251358,
            45666.0541798904,
            45154.77227685815,
            45180.988298181845,
            45272.49234986946,
            45322.35044873266,
            45319.51046441052,
            45411.12529581458
          ]
        ),
        priceChangePercentage24HInCurrency: -3.388388717526743,
        currentHoldings: 1.5)
}
