//
//  NetworkingManager.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/14.
//

import Foundation
import Combine

class NetworkingManager{
    
    // 錯誤時 會跳出的訊息
    enum NetworkingError: LocalizedError{
            
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String?{
            
            // self - (badURLResponse) or (unknown)
            switch self{
            
            case .badURLResponse(url: let url): return " [🥶] Bad response from URL: \(url)"
            case .unknown: return " [😵‍💫]發生未知ㄉ錯誤 Unknow error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        
        return URLSession.shared.dataTaskPublisher(for: url)
     // 可以有       .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0 ,url: url) })       //123123
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output ,url: URL) throws -> Data{
    
           // 123123
           // 通常 200 以上代表 成功響應
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
            
            throw NetworkingError.badURLResponse(url: url)
        }
        print(output.data) // 這時還沒Decode  2個bytes? 3509 -> 1019087
        return output.data
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        
        switch completion{
        case .finished:             // 成功
            break
        case .failure(let error):   // 失敗
            print(error.localizedDescription)
        }
    }
}
