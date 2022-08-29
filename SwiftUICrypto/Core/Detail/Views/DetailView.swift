//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/24.
//

import SwiftUI
struct DetailLoadingView: View {
    
    @Binding var coin :CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel){
        //123123
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
    }
    var body: some View {
        ScrollView{
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20){
                    overviewTitle
                    Divider()
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection

                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
        //.navigationViewStyle()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView{
    
    private var navigationBarTrailingItems: some View{
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
            
        }
    }
    
    private var overviewTitle: some View{
        
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity ,alignment: .leading)
    }
    
    private var additionalTitle: some View{
        
        Text("貨幣詳細資訊")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity ,alignment: .leading)
    }
    
    private var descriptionSection: some View{
        ZStack{
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty{
                VStack{
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeInOut){
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "折疊關閉資訊＾" : "閱讀完整資訊..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical ,4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        
    }
    
    private var overviewGrid: some View{
    
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      pinnedViews: [],
                      content: {
                        ForEach(vm.overviewStatistics){ stat in
                            StatisticView(stat: stat)
                        }
            })
    }
    
    private var additionalGrid: some View {
        
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
                    ForEach(vm.additionalStatistics){ stat in
                        StatisticView(stat: stat)
                    }
        })
    }
    
    private var websiteSection: some View{
        VStack(spacing: 20){
            // 如果獲得 將轉為URL
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString){
                Link("在網頁中開啟...", destination: url)
            }
            if let redditURLString = vm.redditURL,
               let url = URL(string: redditURLString){
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity,alignment: .center)
        .font(.headline)
    }
}
