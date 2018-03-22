//
//  Georgia.swift
//  VendingMachine
//
//  Created by Eunjin Kim on 2018. 1. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Georgia: Coffee {
    private var coffeeExtract: Double = 12.6
    convenience init() {
        self.init(brand: "", weight: 0, price: 0, name: "", manufactureDate: Date(), coffeeExtract: 1, imageName: "georgia.jpg")
    }
    init(brand: String, weight: Int, price: Int, name: String, manufactureDate: Date, coffeeExtract: Double, imageName: String) {
        super.init(brand: brand, weight: weight, price: price, name: name, manufactureDate: manufactureDate, imageName: imageName)
        super.kindOf = "조지아"
    }
    required init?(coder aDecoder: NSCoder) {
        coffeeExtract = aDecoder.decodeDouble(forKey: "coffeeExtract")
        super.init(coder: aDecoder)
    }
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(coffeeExtract, forKey: "coffeeExtract")
    }

    func isRichCoffeeExtract() -> Bool {
        return self.coffeeExtract > 10
    }
}
