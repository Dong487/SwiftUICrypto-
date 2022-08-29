//
//  CoinDataService.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/14.
//

import Foundation
import Combine

class CoinDataService{
    
    @Published var allCoins:[CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    

    init(){
        getCoins()
    }
    
    // 因為重新載入頁面 需要呼叫此函數   所以不用 private
    func getCoins(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=TWD&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
        
    }
}
