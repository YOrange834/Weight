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
    private let otherLine: YOWeightOtherLine
    
    ///
    private let layout: UICollectionViewFlowLayout
    /// 体重数据
    private var dataArr: Array<Double> = []
    
    /// 圆和线
    var lineParModel: YOWightLineParameter?
    
    /// 其他线的参数 ：中线和平均线
    var otherLineParModel: YOWightOtherLineParameter?
    
    static let WEIGHTLINECELL = "WEIGHTLINECELL"
    
    override init(frame: CGRect) {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        otherLine = YOWeightOtherLine(frame: self.bounds)
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){
        self.addSubview(collectionView)
        
        layout.itemSize = CGSize(width: lineParModel!.gridWidth, height: self.frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: self.bounds.width / 2, bottom: 0, right: 0)
        
        collectionView.transform = CGAffineTransform(rotationAngle: Double.pi)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(YOWeightLineCollectionViewCell.self, forCellWithReuseIdentifier: YOWeightLineView.WEIGHTLINECELL)
        
    }

}

// MARK: - API
extension YOWeightLineView{
    func refreshData(_ data: Array<Double>?){
        if data != nil{
            dataArr = data!
        }
        collectionView.reloadData()
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
        cell.lab.text = "\(indexPath.item)"
        return cell
    }
    
    
}
