//
//  YOWeightOtherLine.swift
//  YOWeight
//
//  Created by SYQM on 2022/2/17.
//

import UIKit

class YOWeightOtherLine: UIView {

    /// 中间线
    private let centerLineLayer: CAShapeLayer
    /// 平均线
    private let averageLineLayer: CAShapeLayer
    
    var lineParModel: YOWightLineParameter?
    
    override init(frame: CGRect) {
        centerLineLayer = CAShapeLayer()
        averageLineLayer = CAShapeLayer()
        super.init(frame: frame)
        
        self.layer.addSublayer(centerLineLayer)
        self.layer.addSublayer(averageLineLayer)
    }
    
    func refreshCenterLine(){
        
    }
    
    
    func refreshAvageLine(){
        
    }

}
