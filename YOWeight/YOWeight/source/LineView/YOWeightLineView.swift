//
//  YOWeightLineView.swift
//  YOWeight
//
//  Created by SYQM on 2021/12/29.
//

import UIKit

class YOWeightLineView: UIView {
    ///
    let collectionView: UICollectionView
    ///
    let layout: UICollectionViewFlowLayout
    /// 体重数据
    var dataArr: Array<Float> = []
    
    static let WEIGHTLINECELL = "WEIGHTLINECELL"
    
    override init(frame: CGRect) {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configUI(){
        self.addSubview(collectionView)
        collectionView.transform = CGAffineTransform(rotationAngle: Double.pi)
        collectionView.dataSource = self
        collectionView.dataSource = self
        collectionView.register(YOWeightLineCollectionViewCell.self, forCellWithReuseIdentifier: YOWeightLineView.WEIGHTLINECELL)
        
    }

}

// MARK: - API
extension YOWeightLineView{
    func refreshData(_ data: Array<Float>?){
        if data != nil{
            dataArr = data!
        }
        collectionView.reloadData()
    }
}



extension YOWeightLineView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YOWeightLineCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: YOWeightLineView.WEIGHTLINECELL, for: indexPath) as! YOWeightLineCollectionViewCell
        return cell
    }
    
    
}
