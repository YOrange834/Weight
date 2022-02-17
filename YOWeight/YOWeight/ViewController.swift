//
//  ViewController.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vi  = YOWightView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 120))
        view.addSubview(vi)
        
        var dataArr: Array<Double> = []

        for _ in 0...100 { //正序
            let numberThree: Int = Int(arc4random_uniform(20))
            dataArr.append(Double(numberThree + 60))
            print(numberThree)
        }
        
        vi.refreshData(dataArr)
        
    }


}

