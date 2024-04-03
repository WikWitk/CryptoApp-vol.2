//
//  CryptoVM.swift
//  CryptoAppvol.2
//
//  Created by Wiktor Witkowski on 12/03/2024.
//

import Foundation
@MainActor
class CryptoListVM : ObservableObject {
    
    @Published var cryptoList = [CryptoVM]()
    
    let webService = WebService()
    
    
    func downloadCryptosContinuation(url : URL) async {
        
        do{
            let cryptos = try await webService.downloadCurrenciesContinuation(url: url)
                self.cryptoList = cryptos.map(CryptoVM.init)
            
        }catch {
            print(error)
            
        }
    }
}
    
//    func downloadCryptoAsync(url : URL) async {
//        
//        do {
//            let cryptos = try await webService.downloadDataAsync(url: url)
//            DispatchQueue.main.async {
//                self.cryptoList = cryptos.map(CryptoVM.init)
//            }
//            }catch{
//                print(error)
//            }
//        }
//    }

        
        //    func dowloadCrypto(url : URL) {
        //
        //        webService.downloadData(url: url) { result in
        //
        //            switch result {
        //
        //            case .failure(let error):
        //                print(error)
        //
        //            case .success(let cryptos):
        //                if let cryptos = cryptos {
        //                    DispatchQueue.main.async {
        //                        self.cryptoList = cryptos.map(CryptoVM.init)
        //                    }
        //
        //
        //                }
        //            }
        //        }
        //    }
        
    
    

struct CryptoVM {
    
    let crypto : Currency
    
    var id : UUID? {
        crypto.id
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price
    }
    
    
    
}
