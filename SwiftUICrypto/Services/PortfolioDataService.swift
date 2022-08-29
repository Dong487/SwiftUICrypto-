//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/20.
//

import Foundation
import CoreData

// Core Data
class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    // 初始化
    init() {
        
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Core Data 下載錯誤 \(error)")
            }
            self.getPortfolio()
        }
    }
    
    
    // 公開的 (讓其他地方也能使用)
    
    func updataPortfolio(coin: CoinModel, amount: Double){
        
         /* 相同寫法
            if let entuty = savedEntities.first(where { (savedEntity) -> Bool in
                return savedEntity.coinID == coin.id}){ }
         */
        
        // 檢查 貨幣是否已經存在 個人已擁有的投資組合當中
        if let entity = savedEntities.first(where: { $0.coinID == coin.id}){
           // 判斷以擁有數量有沒有> 0
            if amount > 0{
                // 更新上傳
                update(entity: entity, amount: amount)
            }  else{
                // 刪除
                delete(entity: entity)
                }
        } else{
            // 增加到 Entity 內
            add(coin: coin, amount: amount)
        }
    }
    
    
    
    // 私有 (在這個文件內呼叫執行)
    
    // 解析 Core Data 內的 Portfolio
    private func getPortfolio(){
        //
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do{
            // 發出獲取資料的請求
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching Portfolio Entities\(error)")
        }
    }
    
    // 新增到 Entity 內 (id,amount)
    private func add(coin: CoinModel, amount: Double){
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    // 更新擁有的數量 (已經擁有的貨幣)
    private func update(entity: PortfolioEntity ,amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    // 刪除擁有的貨幣
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    // 儲存實體的動作
    private func save(){
        do{
            try container.viewContext.save()
        } catch let error{
            print(" 儲存到Core Data內時 發生錯誤\(error)")
        }
    }
    
    
    // 變更完成
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
