//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/27.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com/zh-tw")!
    
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let youtube3939889URL = URL(string: "https://www.youtube.com/playlist?list=PLwzRLVfoEfmSOMHq1GZZ-nBVdRhRaSLT7")!
    let youtube1999URL = URL(string: "https://www.youtube.com/playlist?list=PLwzRLVfoEfmTW3pYA9bIxPoCdj7-KfxBO")!
    let youtube117URL = URL(string: "https://www.youtube.com/playlist?list=PLwzRLVfoEfmSdpGfAySDDGGEKZKndnFIs")!
    let youtubeLURL = URL(string: "https://www.youtube.com/playlist?list=PLwzRLVfoEfmSugfBMjlO0z4oEIm-FH9CZ")!
    let youtube55688URL = URL(string: "https://www.youtube.com/playlist?list=PLwzRLVfoEfmQPUjRc5ScS_CQ-DLkSKSIH")!
    

    
    var body: some View {
        NavigationView{
            List{
                swiftfulThinkingSection
                coinGeckoSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Setting")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    
    private var swiftfulThinkingSection: some View{
        Section(header: Text("321312")) {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text("我的歌單3939889 (修改)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("在youtube收聽 歌單 3939889", destination: youtube3939889URL)
            Link("在youtube 首頁搜尋其他歌", destination: youtubeURL)
        }
    }
    
    private var coinGeckoSection: some View{
        Section(header: Text("coinGecko")) {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text("一個查看即時貨幣的平台 並擁有公開免費的API 提供串接")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("在網頁上查看 CoinGecko", destination: coingeckoURL)
            Link("在Google 首頁搜尋其他資訊", destination: defaultURL)
        }
    }
    
    private var applicationSection: some View{
        Section(header: Text("更多 youtube 歌單...")) {
            Link("在youtube收聽 歌單 1999", destination: youtube1999URL)
            Link("在youtube收聽 歌單 55688", destination: youtube55688URL)
            Link("在youtube收聽 歌單 117", destination: youtube117URL)
            Link("在youtube收聽 歌單 3939889", destination: youtube3939889URL)
            Link("在youtube 首頁搜尋其他歌", destination: youtubeURL)
        }
    }
}
