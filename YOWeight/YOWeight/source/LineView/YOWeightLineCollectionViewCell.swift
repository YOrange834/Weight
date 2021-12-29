//
//  YOWeightLineCollectionViewCell.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class YOWeightLineCollectionViewCell: UICollectionViewCell {
    /// 左边的半圆
    let lHRing: CAShapeLayer
    /// 右边的半圆
    let rHRing: CAShapeLayer
    /// 左边的中心的半圆心
    let lCHalfRound: CAShapeLayer
    /// 右边的中心的半圆心
    let rCHalfRound: CAShapeLayer
    /// 两个半圆的连接线
    let line: CAShapeLayer
    
    
    override init(frame: CGRect) {
        lHRing = CAShapeLayer()
        rHRing = CAShapeLayer()
        line = CAShapeLayer()
        lCHalfRound = CAShapeLayer()
        rCHalfRound = CAShapeLayer()
        
        super.init(frame: frame)
        
        self.contentView.layer.addSublayer(line)
        self.contentView.layer.addSublayer(lHRing)
        self.contentView.layer.addSublayer(rHRing)
        self.contentView.layer.addSublayer(lCHalfRound)
        self.contentView.layer.addSublayer(rCHalfRound)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadView(left: Float, right: Float){
        let path = UIBezierPath()
    }
    
    
    
    
}
