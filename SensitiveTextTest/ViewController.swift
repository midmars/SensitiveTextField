//
//  ViewController.swift
//  SensitiveTextTest
//
//  Created by 陳耕霈 on 2023/10/30.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
	var collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
	override func viewDidLoad() {
		self.view.addSubview(collectionView)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = UIColor(red: 77.0/255.0, green: 246.0/255.0, blue: 190.0/255.0, alpha: 0.5)
		collectionView.register(SensitveCell.self, forCellWithReuseIdentifier: "cellId")
		super.viewDidLoad()
		let testAddress = SenitiveTextField()
		let testEmail = SenitiveTextField()
		let testIdNo = SenitiveTextField()
		self.view.addSubview(testAddress)
		self.view.addSubview(testEmail)
		self.view.addSubview(testIdNo)
		collectionView.snp.makeConstraints{
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(500)
		}
		testAddress.snp.makeConstraints{
			$0.centerX.equalToSuperview()
			$0.top.equalTo(self.collectionView.snp.bottom)
			$0.width.equalTo(150)
			$0.height.equalTo(50)
		}
		testEmail.snp.makeConstraints{
			$0.centerX.equalToSuperview()
			$0.top.equalTo(testAddress.snp.bottom).offset(20)
			$0.width.equalTo(200)
			$0.height.equalTo(50)
		}
		testIdNo.snp.makeConstraints{
			$0.centerX.equalToSuperview()
			$0.top.equalTo(testEmail.snp.bottom).offset(20)
			$0.width.equalTo(200)
			$0.height.equalTo(50)
		}

		testAddress.placeholder = "請輸入地址"
		testAddress.backgroundColor =  UIColor.textFieldColor
		testAddress.showEyeButton = .Always
		testAddress.sensitiveType = .address
		testAddress.text =  "1234567jirjqao"
		testAddress.secureTextButton.isSecure = true
		
		
		testEmail.placeholder = "請輸入郵件地址"
		testEmail.backgroundColor = UIColor.textFieldColor
		testEmail.showEyeButton = .Always
		testEmail.sensitiveType = .email
		testEmail.secureTextButton.isSecure = false

		
		testIdNo.placeholder = "請輸入身分字號"
		testIdNo.backgroundColor =  UIColor.textFieldColor
		testIdNo.showEyeButton = .Editing
		testIdNo.sensitiveType = .idNo
		testIdNo.secureTextButton.isSecure = false

	}


}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		3
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 250, height: 55)
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SensitveCell
		if indexPath.item == 0 {
			cell.dataField?.sensitiveType = .email
			cell.dataField?.placeholder = "請輸入email"
		} else if indexPath.item == 1 {
			cell.dataField?.sensitiveType = .idNo
			cell.dataField?.placeholder = "請輸入idNo"
		}
		
		return cell
	}
	
	
}

extension UIColor {
	static var textFieldColor:UIColor {
		return UIColor(red: 189.0/255.0, green: 210.0/255.0, blue: 252.0/255.0, alpha: 1)
	}
}
