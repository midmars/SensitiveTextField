//
//  ShelterType.swift
//  SensitiveTextTest
//
//  Created by 陳耕霈 on 2023/10/31.
//

import Foundation

enum ShelterType {
	case rOCID 
	case phone
	case address
	case email
}

class ShelterManager {
	static func setShelterStr(shelterType: ShelterType, str: String) -> String{
		var strs: String = str
		if str.count < 1 {
			return str
		}
		switch shelterType {
		case .rOCID:
			let startIndex = str.index(str.startIndex, offsetBy: 2)
			let endIndex = str.index(str.startIndex, offsetBy: 5)
			strs.replaceSubrange(startIndex...endIndex, with: "XXXX")
		case .address:
			let length = str.count
			if length > 4 {
				let startIndex = str.index(str.startIndex, offsetBy: length - 4)
				let endIndex = str.index(str.startIndex, offsetBy: length - 1)
				strs.replaceSubrange(startIndex...endIndex, with: "****")
			} else if length>0, length <= 4 {
				let endIndex = str.index(str.startIndex, offsetBy: length - 1)
				strs = "****"
			}
		case .phone:
			if strs.count == 10 {
				let subStr = strs.suffix(3)
				let preStr = strs.prefix(4)
				strs = preStr + "XXX" + subStr
			}
		case .email:
			let index0 = str.firstIndex(of: "@")
			if let index0 = index0 {
				let preStr = String(str.prefix(upTo: index0))
				strs = preStr + "@****"
			}
		default: break
		}
		return strs
	}
}
