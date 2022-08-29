//
//  LocalFileManager.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/14.
//

//  要儲存圖片之前 必須先建立檔案位置

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    private init(){
        
    }
    
    func saveImage(image: UIImage ,imageName: String ,folderName: String){
        
        // 建立 資料夾
        createFolderIfNeeded(folderName: folderName)
        
        // 取得圖片路徑 get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return } // 也可設為 jpegData
        
        // 儲存圖片的路徑
        do {
            try data.write(to: url)

        } catch let error {
            print("儲存 image 失敗 =_= ImageName: \(imageName) \(error)")
        }
    }
    
    func getImage(imageName: String ,folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    private func createFolderIfNeeded(folderName: String){
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        // 如果這個路徑不存在
        if !FileManager.default.fileExists(atPath: url.path){
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("創建目錄失敗 FolderName:\(folderName). \(error)")
            }
        }
    }
    
    
    private func getURLForFolder(folderName: String) -> URL?{
        // for: .cachesDirectory 較不重要的地方。 就算刪除 也能重新Download
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        return url.appendingPathComponent(folderName) // 123123
    }
    
    private func getURLForImage(imageName: String ,folderName: String) -> URL? {
        
        guard let folderURL = getURLForFolder(folderName: folderName) else {
         return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
