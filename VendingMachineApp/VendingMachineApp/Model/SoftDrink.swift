import Foundation

class SoftDrink: Beverage {
    
    private var zeroCalories: Bool
    
    init(brand: Brand.Name, volume: Int, price: Int, productName: String, manufacturedDay: Date, sellByDate: Date, lowCalories: Bool, isHot: Bool, zeroCalories: Bool) {
        self.zeroCalories = zeroCalories
        super.init(brand: brand, volume: volume, price: price, productName: productName, manufacturedDay: manufacturedDay, sellByDate: sellByDate, lowCalories: lowCalories, isHot: isHot)
    }
    
    func discriminateZeroCalories() -> String {
        if zeroCalories { return "YES" }
        else { return "NO" }
    }
}
