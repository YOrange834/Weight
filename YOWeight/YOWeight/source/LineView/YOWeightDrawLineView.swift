//
//  YOWeightDrawLineView.swift
//  YOWeight
//
//  Created by SYQM on 2022/2/16.
//

import UIKit

class YOWeightDrawLineView: UIView {
   
    /// 外圆
    private let outerCircleLayer: CAShapeLayer
    /// 内圆
    private let innerCircleLayer: CAShapeLayer
    /// 连接线
    private let lineLayer: CAShapeLayer
    
    /// 外圆和连接线之间的一点小缺口
//    private let leftSmallPointLayer: CAShapeLayer
//    private let rightSmallPointLayer: CAShapeLayer

    var lineParModel: YOWightLineParameter?
    
    override init(frame: CGRect) {
        outerCircleLayer = CAShapeLayer()
        innerCircleLayer = CAShapeLayer()
//        leftSmallPointLayer = CAShapeLayer()
//        rightSmallPointLayer = CAShapeLayer()
        lineLayer = CAShapeLayer()
        
        super.init(frame: frame)
        
        self.layer.addSublayer(outerCircleLayer)
        self.layer.addSublayer(innerCircleLayer)
//        self.layer.addSublayer(leftSmallPointLayer)
//        self.layer.addSublayer(rightSmallPointLayer)
        self.layer.addSublayer(lineLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Y为圆心的高度
    func reloadView(_ nowCenterY: Double, beforeCenterY: Double){
        assert(lineParModel != nil, "请先设置参数")
        
        let centerX = self.frame.size.width - lineParModel!.outerCircleRadius - lineParModel!.ourerCircleWidth / 2
        
        innerCircleLayer.removeFromSuperlayer()
        outerCircleLayer.removeFromSuperlayer()
        lineLayer.removeFromSuperlayer()

        drawInnerCircle(centerX,centerY: nowCenterY)
        drawOuterCircle(centerX,centerY: nowCenterY)
        if(beforeCenterY >= 0.0 ){
            drawLine(nowCenterY, beforeCenterY: beforeCenterY)
        }
//        drawLRPoint(nowCenterY, beforeCenterY: beforeCenterY)
    }
    
    /// 画内圆
    private func drawInnerCircle(_ centerX: Double,centerY: Double){
        
        
        let path = UIBezierPath.init()
        
        path.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: lineParModel!.innerCircleRadius, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: true)
        
        innerCircleLayer.lineWidth = 0
        innerCircleLayer.strokeColor = lineParModel!.innerCircleColor.cgColor
        innerCircleLayer.path = path.cgPath
        innerCircleLayer.fillColor = lineParModel!.innerCircleColor.cgColor
        layer.addSublayer(innerCircleLayer)
    }
    
    /// 画外圆
    private func drawOuterCircle(_ centerX: Double,centerY: Double){
        
        let path = UIBezierPath.init()

        path.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: lineParModel!.outerCircleRadius, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: true)
        
        outerCircleLayer.lineWidth = lineParModel!.ourerCircleWidth
        outerCircleLayer.strokeColor = lineParModel!.outCircleColor.cgColor
        outerCircleLayer.path = path.cgPath
        outerCircleLayer.fillColor = nil

        layer.addSublayer(outerCircleLayer)
    }
    
    /// 画外圆和其他连接线有点缺口
//    private func drawLRPoint(_ nowCenterY: Double, beforeCenterY: Double){
//
//        leftSmallPointLayer.removeFromSuperlayer()
//        let path = UIBezierPath(rect: CGRect(x: 0, y: beforeCenterY - lineParModel!.ourerCircleWidth / 2, width: 1, height: lineParModel!.ourerCircleWidth))
//
//        leftSmallPointLayer.lineWidth = 0
//        leftSmallPointLayer.strokeColor = lineParModel!.outCircleColor.cgColor
//        leftSmallPointLayer.path = path.cgPath
//        leftSmallPointLayer.fillColor = lineParModel!.outCircleColor.cgColor
//
//        layer.addSublayer(leftSmallPointLayer)
//
//        rightSmallPointLayer.removeFromSuperlayer()
//        let rightPath = UIBezierPath(rect: CGRect(x: self.frame.size.width - 1.0, y: nowCenterY - lineParModel!.ourerCircleWidth / 2, width: 1.0, height: lineParModel!.ourerCircleWidth))
//
//        rightSmallPointLayer.lineWidth = 0
//        rightSmallPointLayer.strokeColor = lineParModel!.outCircleColor.cgColor
//        rightSmallPointLayer.path = rightPath.cgPath
//        rightSmallPointLayer.fillColor = lineParModel!.outCircleColor.cgColor
//
//        layer.addSublayer(rightSmallPointLayer)
//
//    }
//
    
    /// 画连接线
    private func drawLine(_ nowCenterY: Double, beforeCenterY: Double){
        let path = UIBezierPath.init()

        let startPoint = CGPoint(x: 0, y: beforeCenterY)
            
        /// 计算二次贝塞尔曲线的控制点
        let endPointX = self.frame.size.width - lineParModel!.outerCircleRadius * 2 - lineParModel!.ourerCircleWidth
        let endPoint = CGPoint(x: endPointX, y: nowCenterY)
        
        var controlPoint = CGPoint(x: startPoint.x / 2 + endPoint.x / 2, y: startPoint.y / 2 + endPoint.y / 2)
        let diffY = abs(endPoint.y - controlPoint.y)
        if startPoint.y < endPoint.y {
            controlPoint.y += diffY
        }else{
            controlPoint.y -= diffY
        }
            
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        lineLayer.lineWidth = lineParModel!.lineWidth
        lineLayer.strokeColor = lineParModel!.lineColor.cgColor
        lineLayer.path = path.cgPath
        lineLayer.fillColor = nil
        
        layer.addSublayer(lineLayer)
    }

}
