//
//  SearchBarView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/15.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        // 搜尋欄 是否空的   是空的 : 不是空的
                        searchText.isEmpty ?
                            Color.theme.secondaryText : Color.theme.accent)
            
            TextField("搜尋 名稱 或 圖案", text: $searchText)
                .foregroundColor(Color.theme.accent)    // 搜尋欄 輸入的文字顏色
                .disableAutocorrection(true)        // 取消 鍵盤輸入的 智能選字功能
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        // 搜尋欄 有文字的話 則顯示出來刪除圖示  opcity(1)
                        .opacity(searchText.isEmpty ?  0 : 1)
                     //   .background(Color.red)  顯示點擊 x 有效的範圍
                        .onTapGesture {
                            UIApplication.shared.endEditing()   // 關閉鍵盤
                            searchText = ""     // 點擊後將搜尋欄清空
                        }
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
