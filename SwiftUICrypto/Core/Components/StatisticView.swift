//
//  StatisticView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/17.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    var body: some View {
        
        VStack(alignment: .leading ,spacing: 4){
            
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 3) {
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180
                    ))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            
            // 如果沒有 給百分比變化的值 則不顯示 (也可以用if)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}