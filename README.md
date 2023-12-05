# SensitiveTextField
遮蔽字元的textField

## 實作簡易的隱碼輸入欄位，實作規則有:
* 地址
* 信箱
* 手機
* ID(台灣)

## 如何使用

``` swift
    let testEmail = SenitiveTextField()
    testEmail.placeholder = "請輸入郵件地址"
    testEmail.backgroundColor = UIColor.textFieldColor
    testEmail.showEyeButton = .Always
    testEmail.sensitiveType = .email
    testEmail.secureTextButton.isSecure = false
```

## Swift Version
可使用Swift4.2,Swift 5