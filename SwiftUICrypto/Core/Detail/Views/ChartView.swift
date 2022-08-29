//
//  ChartView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/25.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0 // 線圖動畫用
    
    init(coin: CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        
        maxY = data.max() ?? 0  // data 中最大的值 沒有收到data值 則為 0
        minY = data.min() ?? 0
        
        //
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60) // 一秒轉為七天的秒數
    }
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal,4) ,alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal ,4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2)){
                    percentage = 1.0
                }
            }
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView{
    
    private var chartView: some View{
        
        GeometryReader { geometry in
            Path { path in
                for index in data.indices{
                    
                    // 每點起始的 x 軸 位置
                    // 幾何形狀寬度 / 資料的總筆數 * 第幾筆
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat( index + 1) // index 一開始為0 所以+ 1
                    // y 的區間 (最高 - 最低)
                    let yAxis = maxY - minY
                    // y軸 長度
                    // 每一筆的 % 數 ->  ( 1 - (當筆數據 - 最低) / y區間 ) * 幾何形狀高度
                    let yPosition = ( 1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height // 因為上下要顛倒所以 用 1 -
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    // 畫出
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.45), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.23), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground: some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View{
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(( (maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View{
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
        
    }
}
