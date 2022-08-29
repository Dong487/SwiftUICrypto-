//
//  CoinRowView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/13.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn: Bool        //顯示 持有的貨幣
    
    var body: some View {
        HStack(spacing: 0){
            
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(Color.theme.background.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)       // 預覽畫面 為 視窗大小
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)       // 預覽畫面 為 視窗大小
                .preferredColorScheme(.dark)        // 深色模式
        }
    }
}


extension CoinRowView{
    
    // 左側欄位 幣值排名 + 幣值圖案 + 幣值名稱
    private var leftColumn: some View{
        
        HStack(spacing: 0){
            
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30) // 寬最少有30
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())      // uppercased() 變大寫
                .font(.headline)
                .padding(.leading ,6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    // 中間欄位 所擁有的總價值 和 擁有數量
    private var centerColumn: some View {
        
        VStack(alignment: .trailing){
            
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    //  最右邊
    private var rightColumn: some View{
        
        VStack(alignment: .trailing){
        
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                //123123 會因為轉換的幣 不同 匯率也不同 造成字串過長 而到第二行
             //   .font(.system(size: 15))
                .bold()
                .foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                
                // 判斷 幣值 24H內變化 如果 >=0 (上升)為綠的 下降為紅
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 ,alignment: .trailing)
    }
}
