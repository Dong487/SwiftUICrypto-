//
//  CoinImageView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/14.
//

import SwiftUI



struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel){
        
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        
        ZStack{
            // 如果有讀取到圖片
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if vm.isLoading {
                // 加載中...
                ProgressView()
            }else {
                
                // 讀取不到 給ㄍ問號
            
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)   // 預覽框架大小
    }
}
