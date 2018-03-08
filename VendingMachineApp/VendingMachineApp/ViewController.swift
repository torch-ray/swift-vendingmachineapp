//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by yuaming on 08/03/2018.
//  Copyright © 2018 CodeSquad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var beverageImages: [UIImageView]!
    @IBOutlet var addedBeverageButtons: [UIButton]!
    @IBOutlet var beverageQuantityLabels: [UILabel]!
    @IBOutlet var addedMoneyButtons: [UIButton]!
    @IBOutlet weak var moneyLabel: UILabel!
    
    private var vendingMachine: VendingMachine
    
    required init?(coder aDecoder: NSCoder) {
        vendingMachine = VendingMachine()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRoundedImages()
    }
    
    private func setRoundedImages() {
        beverageImages.forEach({
            $0.layer.cornerRadius = 50.0
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.white
        })
    }
    
    @IBAction func insertMoneyAction(_ sender: UIButton) {
        let money: Money = Money(sender.tag)
        try? vendingMachine.insertMoney(coin: money)
        
        updateMoney()
    }
    
    private func updateMoney() {
        moneyLabel.text = "\(vendingMachine.countChange()) 원"
    }
    
    @IBAction func insertBeverageAction(_ sender: UIButton) {
        let beverageMenu: BeverageMenu = matchBeverageMenu(index: sender.tag)
        
        vendingMachine.insertBeverage(beverageMenu: beverageMenu)
        updateBeverageQuantity(index: sender.tag)
    }
    
    private func updateBeverageQuantity(index: Int) {
        let beverageMenu: BeverageMenu = matchBeverageMenu(index: index)
        let quantity: Int = vendingMachine.countBeverageQuantity(beverageMenu: beverageMenu)
        
        beverageQuantityLabels[index].text = "\(quantity) 개"
    }
    
    private func matchBeverageMenu(index: Int) -> BeverageMenu {
        return BeverageMenu.getBeverageMenu(index: index)
    }
}

