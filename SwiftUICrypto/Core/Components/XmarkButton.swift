//
//  XmarkButton.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/18.
//

import SwiftUI

struct XmarkButton: View {
    //關閉 sheet (常用)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        Button(action: {
            
            presentationMode.wrappedValue.dismiss()
            
        }, label: {
        Image(systemName: "xmark")
            .font(.headline)
        })
    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
