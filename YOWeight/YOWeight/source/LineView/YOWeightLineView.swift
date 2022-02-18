//
//  YOWeightLineView.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class YOWeightLineView: UIView {
    /// 体重视图
    private let collectionView: UICollectionView
    
    /// 体重视图
    private let otherLineView: YOWeightOtherLine
    
    ///
    private let layout: UICollectionViewFlowLayout
    /// 体重数据
    private var dataArr: Array<Double> = []
    
    /// 当前选择的体重条目
    private var selectIndex = 0
    
    /// 圆和线
    var lineParModel = YOWightLineParameter()
    
    /// 其他线的参数 ：中线和平均线
    var otherLineParModel = YOWightOtherLineParameter()
    
    static let WEIGHTLINECELL = "WEIGHTLINECELL"
    
    override init(frame: CGRect) {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint.zero, size: frame.size), collectionViewLayout: layout)
        
        otherLineView = YOWeightOtherLine(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        otherLineView.backgroundColor = UIColor.clear
        otherLineView.isUserInteractionEnabled = false
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){
        addSubview(collectionView)
        addSubview(otherLineView)
        
        layout.itemSize = CGSize(width: lineParModel.gridWidth, height: self.frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let leftEdge = self.bounds.width / 2 - lineParModel.outerCircleRadius - lineParModel.outerCircleWidth / 2
        let rightEdge = self.bounds.width / 2 - lineParModel.gridWidth + lineParModel.outerCircleRadius + lineParModel.outerCircleWidth / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftEdge, bottom: 0, right: rightEdge)
        
        collectionView.transform = CGAffineTransform(rotationAngle: Double.pi)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(YOWeightLineCollectionViewCell.self, forCellWithReuseIdentifier: YOWeightLineView.WEIGHTLINECELL)
        
    }

}

// MARK: - API
extension YOWeightLineView{
    
    /// 刷新数据
    func refreshData(_ data: Array<Double>?){
        if data != nil{
            dataArr = data!
        }
        collectionView.reloadData()
    }
    
    /// 刷新数据
    func refreshCenterLine(){
        otherLineView.refreshCenterLine()
    }
    
    /// 刷新数据
    func refreshAvageLine(_ value: Double){
        otherLineView.refreshAvageLine(value)
    }
    
}



extension YOWeightLineView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YOWeightLineCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YOWeightLineView.WEIGHTLINECELL, for: indexPath) as! YOWeightLineCollectionViewCell
        cell.lineParModel = lineParModel
        cell.reloadView(dataArr[indexPath.row], beforeCenterY: dataArr.count > indexPath.item + 1 ? dataArr[indexPath.row + 1] : -1)
        cell.showInnerCircle(selectIndex == indexPath.item)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("+++++\(scrollView.contentOffset.x)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            setLineViewContentOffset(scrollView)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setLineViewContentOffset(scrollView)
    }
    
    
    func setLineViewContentOffset(_ scrollView: UIScrollView){
        // 四舍五入
        let selectIndex = Int(scrollView.contentOffset.x / lineParModel.gridWidth + 0.5)
        scrollView.setContentOffset(CGPoint(x: Double(selectIndex) * lineParModel.gridWidth, y: 0), animated: true)
        if selectIndex != self.selectIndex {
            self.selectIndex = selectIndex
            collectionView.reloadData()
        }
        
    }
    
}
