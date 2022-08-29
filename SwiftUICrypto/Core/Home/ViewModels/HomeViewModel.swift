//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/13.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
/* 測試時可以先提供 假數據
     [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 11),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: -21),
     ]
 */
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    @Published var isLoading: Bool = false
    
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataSevice = PortfolioDataService()   // Data Core
    private var cancellables = Set<AnyCancellable>()
    
    // 排列選項
    enum SortOption{
        
        case rank ,rankReversed ,holdings ,holdingsReversed ,price ,priceReversed
        
    }
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        // 搜尋功能 (updates allCoins)
        $searchText
            .combineLatest(coinDataService.$allCoins ,$sortOption)
            // 當輸入停止0.5秒後 才會執行 資料搜尋 (防止輸入時一直執行)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // 123123
        // updates portfolioCoins
        
        $allCoins
            
            .combineLatest(portfolioDataSevice.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            // marketDataModel 模型轉換為 StatisticModel
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false  // 重新載入後 結束時將狀態改回false
            }
            .store(in: &cancellables)

    }
    
    // 更新 持有coin 數量
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataSevice.updataPortfolio(coin: coin, amount: amount)
    }
    
    // 重新整理頁面(重新下載數據)
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String ,coins: [CoinModel] ,sort: SortOption) -> [CoinModel] {
        
        var updatedCoins = filterCoins(text: text, coins: coins)
        
        sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
    }
    
    private func filterCoins(text: String ,coins: [CoinModel]) -> [CoinModel]{
        
        // 如果 text 不是空的 執行... 不然 return startCoins
        guard !text.isEmpty else{
            return coins
        }
        
        // 把text 變小寫 方便搜尋
        let lowercasedText = text.lowercased()
        
        // 搜尋 text symbol id 內 符合搜尋條件相關的
        return coins.filter { (coin)-> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    // inout 123213 會使運作速度較快
    // 排序 (holding 還沒 )
    private func sortCoins(sort: SortOption ,coins:  inout [CoinModel]){
        
        switch sort {
        case .rank , .holdings:
            coins.sort(by: {$0.rank < $1.rank}) //  return coins.sorted { (coin1, coin2) -> Bool inreturn coin1.rank < coin2.rank }
        case .rankReversed , .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    // holding 和 holdingsReversed
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue})  // 所持有的總價值 排序 (單價 * 持有數 )
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})  // 所持有的總價值 排序 (單價 * 持有數 )
        default:
            return coins
        }
    }
    
    
    private func mapAllCoinsToPortfolioCoins(allcoins: [CoinModel] ,portfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        
        // 123123
        // 如果有在 portfolioEntities 中 找到相同的coin.id
        allcoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount) // 將 entity的數量 回傳 到 CoinModel中 的 持有數量
            }
    }
    
    
    // marketDataModel 模型轉換為 StatisticModel
    private func mapGlobalMarketData(marketDataModel: MarketDataModel? ,portfolioCoins: [CoinModel]) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else{
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
            // 當前擁有全部貨幣的總價值
        let portfolioValue =
            portfolioCoins
                .map( { $0.currentHoldingsValue })
                .reduce(0, +) // 將 符合map 全部相加
        
        
            // 24小時之前的價值
            // 藉由 API當中給的 priceChangePercentage24H (24小時變化量) 推算
            //
            //
        let previousValue =
                portfolioCoins
                    .map{ (coin) -> Double in
                            // 當前擁有總價值
                        let currentValue = coin.currentHoldingsValue
                        
                            // 將原本 priceChangePercentage24H / 100 ->  假設 原本為 75% 轉為 0.75
                        let percentChange =  (coin.priceChangePercentage24H ?? 0) / 100
                        
                        let previousValue = currentValue / (1 + percentChange)  //123123
                        
                        return previousValue
                    }
                    .reduce(0, +)
        
            // Ex: percentageChange = (    110   -   100   ) / 100          *100 -> 10%
            //               變化量   =  ( 當前價格 - 24H前價格 ) / 24H前價格      *100轉為百分比  10%
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    
    }
}
