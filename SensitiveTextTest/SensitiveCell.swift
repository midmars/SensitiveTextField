//
//  SensitiveCell.swift
//  SensitiveTextTest
//
//  Created by 陳耕霈 on 2023/11/14.
//

import UIKit

/// 測試CollectionView加入SenitiveTextField
class SensitveCell: UICollectionViewCell {
	
	var dataField:SenitiveTextField?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setUp()
	}
	
	func setUp(){
		dataField = SenitiveTextField()
		dataField!.placeholder = "請輸入資料"
		dataField!.backgroundColor = .clear
		dataField!.showEyeButton = .Always
		dataField!.sensitiveType = .normal
		dataField!.secureTextButton.isSecure = true
		
		self.addSubview(dataField!)
		dataField?.snp.makeConstraints{
			$0.top.bottom.trailing.leading.equalToSuperview()
		}
	}
}
