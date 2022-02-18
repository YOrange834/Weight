//
//  YOWeightLineCollectionViewCell.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class YOWeightLineCollectionViewCell: UICollectionViewCell {
    
    let lineView = YOWeightDrawLineView()
    var lineParModel: YOWightLineParameter?

    override init(frame: CGRect) {
        super.init(frame: frame)
        lineView.frame = self.bounds
        self.contentView.transform = CGAffineTransform(rotationAngle: -Double.pi)
        self.contentView.addSubview(lineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadView(_ nowCenterY: Double, beforeCenterY: Double){
        lineView.lineParModel = lineParModel
        lineView.reloadView(nowCenterY, beforeCenterY: beforeCenterY)
    }
    
    func showInnerCircle(_ show: Bool){
        lineView.innerCircleLayer.isHidden = !show
    }
    
    
}
