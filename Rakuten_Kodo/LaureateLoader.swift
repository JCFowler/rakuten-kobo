//
//  LaureateLoader.swift
//  Rakuten_Kodo
//
//  Created by John Fowler on 1/10/21.
//

import Foundation
import CoreLocation

public class LaureateLoader {
    @Published var laureateData = [Laureate]()
    
    init() {
        load()
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJSON = try jsonDecoder.decode([Laureate].self, from: data)
                
                self.laureateData = dataFromJSON
            } catch {
                print (error)
            }
        }
    }
}
