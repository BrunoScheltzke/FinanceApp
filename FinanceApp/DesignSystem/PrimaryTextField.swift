//
//  PrimaryTextField.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import JMMaskTextField_Swift

@IBDesignable
class PrimaryTextField: SkyFloatingLabelTextFieldWithIcon {

    public private(set) var stringMask: JMStringMask?
    fileprivate weak var realDelegate: UITextFieldDelegate?
    
    @IBInspectable
    var isPrimaryStyle: Bool = true {
        didSet {
            setupStyle()
        }
    }
    
    var icon: UIImage? {
        didSet {
            iconImage = icon
            iconWidth = icon == nil ? 0 : 20
        }
    }

    @IBInspectable
    var isOptionalField: Bool = false
    
    var isValidText: Bool {
        get {
            if !isOptionalField {
                if let maskString = maskString {
                    return maskedText.count == maskString.count
                }
                return !(text ?? "").isEmpty
            }
            return true
        }
    }
    
    override var text: String? {
        didSet {
            errorMessage = isValidText ? nil : invalidMessage
        }
    }
    
    var invalidMessage: String?
    
    override weak open var delegate: UITextFieldDelegate? {
        get {
            return self.realDelegate
        }
        
        set (newValue) {
            self.realDelegate = newValue
            super.delegate = self
        }
    }
    
    public var maskedText: String {
        get {
            return text ?? ""
        }
    }
    
    public var unmaskedText: String {
        get {
            return self.stringMask?.unmask(string: self.text) ?? self.maskedText
        }
    }
    
    @IBInspectable open var maskString: String? {
        didSet {
            guard let maskString = self.maskString else { return }
            self.stringMask = JMStringMask(mask: maskString)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        super.delegate = self
        let titleSize: CGFloat = UIDevice().isSmall ? 15 : 17
        font = Font.poppins(ofSize: titleSize)
        iconImage = icon
        if iconImage == nil {
            iconWidth = 0
        }
        selectedTitle = placeholder
        textColor = .black
        
        setupStyle()
    }
    
    func setupStyle() {
        if isPrimaryStyle {
            cornerRadius = 8
            tintColor = .mainBlue
            selectedLineColor = .mainBlue
            selectedTitleColor = .mainBlue
            backgroundColor = #colorLiteral(red: 0.8312816024, green: 0.8314250112, blue: 0.8312725425, alpha: 1)
        } else {
            backgroundColor = .clear
            tintColor = .mainBlue
            lineColor = .mainBlue
            selectedLineColor = .mainBlue
            selectedTitleColor = .mainBlue
        }
    }
    
    override func titleHeight() -> CGFloat {
        let defaultHeight = super.titleHeight()
        return isPrimaryStyle ? defaultHeight + 15.0 : defaultHeight
    }
    
    override var intrinsicContentSize: CGSize {
        let height: CGFloat = 60
        var width: CGFloat = 100 + iconWidth
        if let font = font,
            let calculatedWidth = placeholder?.width(withConstrainedHeight: height, font: font),
            calculatedWidth != 0 {
            width = calculatedWidth + 40
        }
        return CGSize(width: width, height: height)
    }
    
    func maskText(_ string: String?) {
        guard let mask = stringMask else {
            text = string
            return
        }
        text = mask.mask(string: string)
    }
    
}

extension PrimaryTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.realDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.realDelegate?.textFieldDidEndEditing?(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let previousMask = self.stringMask
        let currentText: NSString = textField.text as NSString? ?? ""
        
        if let realDelegate = self.realDelegate, realDelegate.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) {
            let delegateResponse = realDelegate.textField!(textField, shouldChangeCharactersIn: range, replacementString: string)
            
            if !delegateResponse {
                return false
            }
        }
        
        guard let mask = self.stringMask else { return true }
        
        let newText = currentText.replacingCharacters(in: range, with: string)
        var formattedString = mask.mask(string: newText)
        
        // if the mask changed or if the text couldn't be formatted,
        // unmask the newText and mask it again
        if (previousMask != nil && mask != previousMask!) || formattedString == nil {
            let unmaskedString = mask.unmask(string: newText)
            formattedString = mask.mask(string: unmaskedString)
        }
        
        guard let finalText = formattedString as NSString? else { return false }
        
        // if the cursor is not at the end and the string hasn't changed
        // it means the user tried to delete a mask character, so we'll
        // change the range to include the character right before it
        if finalText == currentText && range.location < currentText.length && range.location > 0 {
            return self.textField(textField, shouldChangeCharactersIn: NSRange(location: range.location - 1, length: range.length + 1) , replacementString: string)
        }
        
        if finalText != currentText {
            textField.text = finalText as String
            
            // the user is trying to delete something so we need to
            // move the cursor accordingly
            if range.location < currentText.length {
                var cursorLocation = 0
                
                if range.location > finalText.length {
                    cursorLocation = finalText.length
                } else if currentText.length > finalText.length {
                    cursorLocation = range.location
                } else {
                    cursorLocation = range.location + 1
                }
                
                guard let startPosition = textField.position(from: textField.beginningOfDocument, offset: cursorLocation) else { return false }
                guard let endPosition = textField.position(from: startPosition, offset: 0) else { return false }
                textField.selectedTextRange = textField.textRange(from: startPosition, to: endPosition)
            }
            return false
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldClear?(textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let textField = textField as? PickerTextField<Continent>{
//            if let item = textField.selectedItem {
//                textField.didClickReturn?(item)
//            }
//        }
        return self.realDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
}
