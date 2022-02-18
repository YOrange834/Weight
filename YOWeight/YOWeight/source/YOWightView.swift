//
//  YOWightView.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class YOWightView: UIView {
    /// 体重视图
    private var wightLineView: YOWeightLineView!
        
    /// 中间线和平均线设置
    private var otherLineView: YOWeightOtherLine!
    
    /// 体重数据
    private var dataArr: Array<Double> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configUI(){
        /// 初始化曲线图
        wightLineView = YOWeightLineView(frame: self.bounds)
        addSubview(wightLineView)
        wightLineView.lineParModel = YOWightLineParameter()
        wightLineView.otherLineParModel = YOWightOtherLineParameter()
        
        wightLineView.configUI()
        
        /// 初始化中线和平均线
        otherLineView = YOWeightOtherLine(frame: self.bounds)
        addSubview(otherLineView)
        otherLineView.backgroundColor = UIColor.clear
        otherLineView.isUserInteractionEnabled = false
        otherLineView.refreshCenterLine()
    }
    
}


extension YOWightView{
    /// 刷新数据
    func refreshData(_ data: Array<Double>?){
        if data != nil{
            dataArr = data!
            
            // TODO : 需要找出最大值和最小值，让数据区域中间的数据 ，同时修改平均值
            
            
            let min = data!.min()
            let max = data!.max()
        }
        wightLineView.refreshData(dataArr)
    }
        
    /// 刷新目标线
    func refreshAvageLine(_ value: Double){
        otherLineView.refreshAvageLine(value)
    }
}



struct YOWightLineParameter {
    /// 外圆的半径
    var outerCircleRadius = 6.0
    /// 外圆的宽度
    var outerCircleWidth = 2.0
    /// 外圆的颜色
    var outCircleColor = UIColor.red
    
    /// 内圆的半径
    var innerCircleRadius = 3.0
    /// 内圆的颜色
    var innerCircleColor = UIColor.red
    
    /// 线条的宽度
    var lineWidth = 2.0
    /// 线条的颜色
    var lineColor = UIColor.red
    
    /// 格子的大小，每条数据的宽度
    var gridWidth = 50.0
    
}


struct YOWightOtherLineParameter {
    /// 中间线的颜色
    var centerLineColor = UIColor.red
    /// 中间线的宽度
    var centerLineWidth = 1.0
    
    /// 是否是虚线
    var isDottedLine = true
    /// 平均线的颜色
    var averageLineColor = UIColor.red
    /// 虚线宽度
    var averageLineWidth = 1.0
    /// 每段线条的长度
    var dottedWidth = 6.0
    /// 虚线空白的长度
    var blankWidth = 2.0
    
}
