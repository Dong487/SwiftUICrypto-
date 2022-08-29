//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/14.
//
//  檢查手機內暫存檔案 圖片是否已經下載過
//  找到手機暫存內有圖片 直接從手機資料夾內獲取
//  如果沒有下載過 從URL下載 並 儲存到手機資料夾內
//
//  藉此減少 Data需要重複下載的情況
//  假如手機暫存滿 則會影響到圖片的暫存資料  開啟可能需要重新download、儲存

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        
        getCoinImage()
    }

    private func getCoinImage(){
        
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
            print("圖片是從 File Manager 獲取")
        }else{
            // 如果沒有圖片 從URL下載圖片
            downloadCoinImage()
            print("從URL下載圖片中...")

        }
    }
    
    private func downloadCoinImage(){
        print("下載圖片中...")
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                //123123
                guard let self = self , let downloadedImage = returnedImage else { return }
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                
                // 儲存 image
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
