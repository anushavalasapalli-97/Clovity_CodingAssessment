//
//  CountriesViewModel.swift
//  Clovity-CodeAssessment
//
//  Created by AnushaValasapalli on 7/26/23.
//


import Foundation
import Combine

class CountriesViewModel: ObservableObject {
    @Published var countries: [Country] = []
    
    private var bag = Set<AnyCancellable>()
    
    
    func fetchCountries() {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            return
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        
        let cancellable = publisher
            .map(\.data)
            .decode(type: [Country].self , decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
        
            .sink(receiveCompletion: { completion in
                switch completion {
                    case.finished:
                        print("finished")
                    case.failure( let error):
                        print("Api error: \(error)")
                }
                
            }, receiveValue: { response in
                print("response: \(response)")
                self.countries = response
                print("countries:", self.countries)
                
            }).store(in: &bag)
        
        
    }
    
}

struct CountriesResponse: Codable {
    let countries: [Country]
}


