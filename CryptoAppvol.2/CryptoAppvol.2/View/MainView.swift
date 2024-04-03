//
//  ContentView.swift
//  CryptoAppvol.2
//
//  Created by Wiktor Witkowski on 12/03/2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListVM : CryptoListVM
    
    init() {
        self.cryptoListVM = CryptoListVM()
    }
    
    var body: some View {
        
        NavigationView {
            
            List(cryptoListVM.cryptoList, id:\.id){ crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(crypto.price)
                        .foregroundStyle(.cyan)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }.toolbar(content: {
                Button {
                    //
                    Task.init {
                        await cryptoListVM.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    Text("Refresh")
                }

            })
            
            .navigationTitle("Crypto App")
                
        }.task{
            
            await cryptoListVM.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//            await cryptoListVM.downloadCryptoAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
        //.onAppear{
            
       
//            cryptoListVM.dowloadCrypto(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
       // }
        
    }
}

#Preview {
    MainView()
}

