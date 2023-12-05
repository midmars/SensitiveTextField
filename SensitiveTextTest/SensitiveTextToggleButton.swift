//
//  SensitiveTextToggleButton.swift
//  HappyGo-SIT
//
//  Created by 陳耕霈 on 2023/10/30.
//  Copyright © 2023 mtelnet. All rights reserved.
//

import Foundation
import UIKit

class SensitiveTextToggleButton: UIButton {
	fileprivate let RightMargin: CGFloat = 10.0
	fileprivate let Width: CGFloat = 30.0
	fileprivate let Height: CGFloat = 30.0
	weak var delegate: SensitiveTextFieldDelegate?

	@objc dynamic  open var isSecure: Bool = true {
		didSet {
			if isSecure {
				setEyeOn()
			} else {
				setEyeOff()
			}
		}
	}

	/// Image to shown when the visibility is on
	open var showSecureImage: UIImage = .init(named: "eye.slash")!{
		didSet{
			self.setImage(showSecureImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State())
		}
	}

	/// Image to shown when the visibility is off
	open var hideSecureImage: UIImage = .init(named: "eye")!
	open var imageTint: UIColor = .gray{
		didSet{
			self.tintColor = imageTint
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	func setup() {
		self.frame = CGRect(x: 0, y: 0, width: showSecureImage.size.width + RightMargin, height: showSecureImage.size.height)
		self.contentMode = UIView.ContentMode.scaleAspectFit
		self.tintColor = imageTint
		self.backgroundColor = .clear
		isSecure = true
		self.addTarget(self, action: #selector(eyeButtonTap), for: .touchUpInside)
	}

	/**
	 Updates the image and the set the visibility on icon
	 */
	func setEyeOn() {
		self.setImage(showSecureImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State())
	}

	/**
	 Update teh image and sets the visibility off icon
	 */
	func setEyeOff() {
		self.setImage(hideSecureImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State())
	}

	@objc func eyeButtonTap() {
		self.isSelected.toggle()
		isSecure.toggle()
	}
}

protocol SensitiveTextFieldDelegate: AnyObject {
	func buttonTap(open:Bool)
}
