//
//  PortfolioView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/18.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading ,spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("編輯 投資組合")
            
            // ios13-14.3
            // navigationBarItems 未來改用 toolbar(context:)
            //.navigationBarItems(leading: XmarkButton())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            })
            // 儲存完後 或 搜尋欄為空的 下面的投資組合數據 將消失
            .onChange(of: vm.searchText, perform: { value in
                // 如果 value 為空的 (searchText 搜尋欄文字為空的)
                if value == ""{
                    // 清除掉搜尋的硬幣
                    removeSelectedCoin()
                }
            })
            
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView {
    
    private var coinLogoList: some View{
        
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10 ){
                // 如果搜尋欄 是空的 按照順序顯示虛擬貨幣 : 擁有的虛擬貨幣
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                updateSelectedCoin(coin: coin)

                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .trim(from: 0, to: 0.85)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,lineWidth: 1.0)
                                
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings{
                quantityText = "\(amount)"
        }
        // 找不到 portfolioCoin , 沒有amount
        else {
            quantityText = ""
        }
     }
  
    
    

    
    private func getCurrentValue() -> Double{
        
        // 先把 String 轉換成Double
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0) // 如沒有讀取到 則為0
        }
        // 如果 quantity= 0 則回傳 0
        return 0
    }
    
    private var portfolioInputSection: some View{
        
        VStack(spacing: 20){
            HStack{
                // 如果沒有資料 -> ""  回覆一個空的字串
                Text(" \(selectedCoin?.symbol.uppercased() ?? "") 當前價格:")
                
                Spacer()
                
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            
            HStack{
                Text("目前你擁有的數量:")
                
                Spacer()
                
                TextField("例如: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad) // 輸入擁有數量 的鍵盤 (純數字鍵盤較佳)
            }
            Divider()
            
            HStack{
                Text("所擁有的總價值:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View{
        
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("儲存")
            })
            .opacity(
                selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    // 按下右上 儲存後 的動作
    private func saveButtonPressed(){
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
            // 儲存到 portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
            // show Checkmark
            withAnimation(.easeInOut){
                showCheckmark = true
                removeSelectedCoin()
            }
            // 隱藏 鍵盤
            UIApplication.shared.endEditing()
            
            // +2秒後 重新隱藏 checkmark
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut){
                    showCheckmark = false
                }
            }
        
    }
    
    // 取消掉所選的coin
    private func removeSelectedCoin(){
        
        selectedCoin = nil
        vm.searchText = ""
    }
}
