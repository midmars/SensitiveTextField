//
//  SensitiveTextField.swift
//  HappyGo-SIT
//
//  Created by 陳耕霈 on 2023/10/30.
//  Copyright © 2023 mtelnet. All rights reserved.
//

import UIKit

enum SenitiveFieldType {
	case idNo
	case email
	case address
	case normal
}


class SenitiveTextField: UITextField, SensitiveTextFieldDelegate, UITextFieldDelegate {
	var alwaysOpen: Bool = false

	open lazy var secureTextButton = SensitiveTextToggleButton()
	fileprivate var kvoContext: UInt8 = 0
	public enum ShowButtonWhile: String {
		case Editing = "editing"
		case Always = "always"
		case Never = "never"
		var textViewMode: UITextField.ViewMode {
			switch self{
			case .Editing:
				return .whileEditing
			case .Always:
				return .always
			case .Never:
				return .never
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		setup()
	}

	var showEyeButton = ShowButtonWhile.Editing {
		didSet {
			self.rightViewMode = self.showEyeButton.textViewMode
		}
	}

	var isOpenWhileEditing = true
	private var originText = ""

	open func setSecureMode(_ secure: Bool) {
		if secure {
			originText = self.text ?? ""
			let tempText = self.text
			switch sensitiveType {
			case .idNo:
				self.text = ShelterManager.setShelterStr(shelterType: .rOCID, str: tempText ?? "")
			case .email:
				self.text = ShelterManager.setShelterStr(shelterType: .email, str: tempText ?? "")
			case .address:
				self.text = ShelterManager.setShelterStr(shelterType: .address, str: tempText ?? "")
			default:
				break
			}
			self.resignFirstResponder()
		} else {
			self.text = originText
		}
	}

	var sensitiveType: SenitiveFieldType = .normal
	func setup() {
		self.rightViewMode = self.showEyeButton.textViewMode
		self.rightView = self.secureTextButton

		self.secureTextButton.addObserver(self, forKeyPath: "isSecure", options: NSKeyValueObservingOptions.new, context: &kvoContext)
		self.addTarget(self, action: #selector(updateText(_:)), for: .editingChanged)
		self.secureTextButton.delegate = self
		delegate = self
	}

	deinit {
		self.secureTextButton.removeObserver(self, forKeyPath: "isSecure")
	}
}

extension SenitiveTextField {
	func buttonTap(open: Bool) {
		self.setSecureMode(open)
	}

	override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
		if context == &kvoContext {
			if context == &kvoContext {
				self.setSecureMode(self.secureTextButton.isSecure)

			} else {
				super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
			}
		}
	}
}

extension SenitiveTextField {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = originText
		secureTextButton.isSecure = false
	}
	func textField(_: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if let swiftRange = Range(range, in: originText) {
			originText = originText.replacingCharacters(in: swiftRange, with: string)
		} else {
			// 如果 range 無效（例如當刪除時 range 會超出字串範圍），則直接添加 string 到 originText
			originText += string
		}
		return true
	}
	
	@objc func updateText(_ textfield : UITextField) {
		if isOpenWhileEditing,secureTextButton.isSecure {
			textfield.text = originText
			secureTextButton.isSecure = false
			
		}
	}
}
