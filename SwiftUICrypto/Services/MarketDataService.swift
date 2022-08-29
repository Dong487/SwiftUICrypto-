//
//  MarketDataService.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/17.
//

import Foundation
import Combine

// URL: https://api.coingecko.com/api/v3/global

class MarketDataService{
    
    @Published var marketData: MarketDataModel? = nil   //123123

    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
    // 因為重新載入頁面 需要呼叫此函數   所以不用 private
    func getData(){

        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
        
    }
}
