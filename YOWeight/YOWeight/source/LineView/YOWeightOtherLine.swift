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
    
    var lineParModel = YOWightOtherLineParameter()
    
    override init(frame: CGRect) {
        centerLineLayer = CAShapeLayer()
        averageLineLayer = CAShapeLayer()
        super.init(frame: frame)
        
        self.layer.addSublayer(centerLineLayer)
        self.layer.addSublayer(averageLineLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCenterLine(){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width / 2.0 - lineParModel.centerLineWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width / 2.0  - lineParModel.centerLineWidth / 2,y: self.frame.height))
        
        centerLineLayer.lineWidth = lineParModel.centerLineWidth
        centerLineLayer.strokeColor = lineParModel.centerLineColor.cgColor
        centerLineLayer.fillColor = lineParModel.centerLineColor.cgColor
        
        centerLineLayer.path = path.cgPath
        layer.addSublayer(centerLineLayer)
    }
    
    
    func refreshAvageLine(_ value: Double){
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: value))
        path.addLine(to: CGPoint(x: self.frame.width,y: value))
        
        averageLineLayer.lineWidth = lineParModel.averageLineWidth
        averageLineLayer.strokeColor = lineParModel.averageLineColor.cgColor
        averageLineLayer.fillColor = lineParModel.averageLineColor.cgColor
        
        
        if lineParModel.isDottedLine {
            averageLineLayer.lineDashPattern = [NSNumber(value: lineParModel.dottedWidth),NSNumber(value: lineParModel.blankWidth)]
        }

        averageLineLayer.path = path.cgPath
        layer.addSublayer(averageLineLayer)
        
    }

}
