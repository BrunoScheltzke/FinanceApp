//
//  MaskedTextFields.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 05/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

class Mask {
    
    static let cellphone = "(00)00000-0000"
    static let cep = "00000-000"
    static let cpf = "000.000.000-00"
    static let birthdate = "dd/MM/yyyy"
    static let dateTime = "dd/MM/yyyy hh:mm a"
    static let dateTimeFull = "dd/MM/yyyy HH:mm"
    static let cnpj = "00. 000. 000/0000-00"
    static let time = "HH:mm"
    
}

enum PersonCategory: String, CaseIterable, PickerSelectable {
    case person = "Pessoa Física"
    case company = "Pessoa Jurídica"
    
    var title: String {
        return self.rawValue
    }
}

class CPFTextField: PrimaryTextField {
    
    var personCategory: PersonCategory = .person {
        didSet {
            switch personCategory {
            case .person:
                maskString = Mask.cpf
                invalidMessage = "CPF inválido"
                placeholder = "Digite um cpf"
                title = "CPF"
            case .company:
                maskString = Mask.cnpj
                invalidMessage = "CNPJ inválido"
                placeholder = "Digite um cnpj"
            }
            if let text = text, !text.isEmpty {
                self.text = nil
            }
        }
    }
    
    override var isValidText: Bool {
        get {
            guard super.isValidText else { return false }
            if personCategory == .person {
                return unmaskedText.isValidCPF
            } else {
                return unmaskedText.isValidCNPJ
            }
        }
    }
    
    override func commonInit() {
        super.commonInit()
        keyboardType = .numberPad
        personCategory = .person
    }
    
}

class PasswordTextField: PrimaryTextField {
    
    override func commonInit() {
        super.commonInit()
        isSecureTextEntry = true
        invalidMessage = "Senha inválida"
        placeholder = "Digite sua senha"
        title = "Senha"
    }
    
}

class PasswordConfTextField: PrimaryTextField {
    
    override func commonInit() {
        super.commonInit()
        isSecureTextEntry = true
        invalidMessage = "Senha inválida"
        placeholder = "Confirme sua senha"
        title = "Confirme sua senha"
    }
    
}

class EmailTextField: PrimaryTextField {
    
    override var isValidText: Bool {
        get {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: unmaskedText)
        }
    }
    
    override func commonInit() {
        super.commonInit()
        invalidMessage = "Email inválido"
        placeholder = "Email"
        title = "Email"
    }
    
}

class NameTextField: PrimaryTextField {
    
    var minimunChar: Int = 8
    
    override var isValidText: Bool {
        get {
            return unmaskedText.count > minimunChar && unmaskedText.contains(" ")
        }
    }
    
    override func commonInit() {
        super.commonInit()
        invalidMessage = "Nome inválido"
        placeholder = "Nome"
        title = "Nome"
    }
    
}

class CellphoneTextField: PrimaryTextField {
    
    override func commonInit() {
        super.commonInit()
        maskString = Mask.cellphone
        placeholder = "Digite um celular"
        invalidMessage = "Celular inválido"
        title = "celular"
        keyboardType = .numberPad
    }
    
}

class CepTextField: PrimaryTextField {
    
    override func commonInit() {
        super.commonInit()
        maskString = Mask.cep
        placeholder = "Digite um cep"
        invalidMessage = "Cep inválido"
        title = "Cep"
        keyboardType = .numberPad
    }
    
}

class DateTextField: PrimaryTextField {
    
    var date: Date? {
        get {
            return dateFormatter.date(from: text ?? "")
        }
    }
    
    let dateFormatter = DateFormatter()
    let datePickerView = UIDatePicker()
    
    var dateFormat: String = Mask.birthdate
    
    override func commonInit() {
        super.commonInit()
        placeholder = "Selecione uma data"
        title = "Data"
        
        dateFormatter.dateFormat = dateFormat
        datePickerView.datePickerMode = .date
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }

    @objc func handleDatePicker(sender: UIDatePicker) {
        self.text = dateFormatter.string(from: sender.date)
    }
    
}

class DateTimeTextField: DateTextField {
    
    override func commonInit() {
        dateFormat = Mask.dateTime
        super.commonInit()
        datePickerView.datePickerMode = .dateAndTime
    }
    
}

class CurrencyTextField: PrimaryTextField {
    
    override func commonInit() {
        super.commonInit()
        placeholder = "Digite um valor"
        title = "Valor"
        keyboardType = .numberPad
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "R$ "
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumFractionDigits = 2
        setAmount(defaultValue)
    }
    
    private let maxDigits = 12
    private var defaultValue = 0.00
    private let currencyFormatter = NumberFormatter()
    private var previousValue = ""
    
    var value: Double {
        get { return Double(getCleanNumberString()) ?? 0 / 100 }
        set { setAmount(newValue) }
    }
    
    // MARK: - UITextField Notifications
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        let cursorOffset = getOriginalCursorPosition()
        let cleanNumericString = getCleanNumberString()
        let textFieldLength = text?.count
        let textFieldNumber = Double(cleanNumericString)
        
        if cleanNumericString.count <= maxDigits && textFieldNumber != nil {
            setAmount(textFieldNumber! / 100)
        } else {
            text = previousValue
        }
        
        setCursorOriginalPosition(cursorOffset, oldTextFieldLength: textFieldLength)
    }
    
    //MARK: - Custom text field functions
    
    private func setAmount (_ amount : Double){
        let textFieldStringValue = currencyFormatter.string(from: NSNumber(value: amount))
        text = textFieldStringValue
        textFieldStringValue.flatMap { previousValue = $0 }
    }
    
    //MARK - helper functions
    
    private func getCleanNumberString() -> String {
        return text?.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined() ?? ""
    }
    
    private func getOriginalCursorPosition() -> Int{
        guard let selectedTextRange = selectedTextRange else { return 0 }
        return offset(from: beginningOfDocument, to: selectedTextRange.start)
    }
    
    private func setCursorOriginalPosition(_ cursorOffset: Int, oldTextFieldLength : Int?) {
        let newLength = text?.count
        let startPosition = beginningOfDocument
        if let oldTextFieldLength = oldTextFieldLength, let newLength = newLength, oldTextFieldLength > cursorOffset {
            let newOffset = newLength - oldTextFieldLength + cursorOffset
            let newCursorPosition = position(from: startPosition, offset: newOffset)
            if let newCursorPosition = newCursorPosition {
                let newSelectedRange = textRange(from: newCursorPosition, to: newCursorPosition)
                selectedTextRange = newSelectedRange
            }
        }
    }
    
}

enum ZoneSelectable: String, CaseIterable, PickerSelectable {
    case north = "Zona norte"
    case south = "Zona sul"
    
    var title: String {
        return self.rawValue
    }
    
    var id: Int {
        switch self {
        case .north: return 1
        case .south: return 2
        }
    }
}

protocol PickerSelectable {
    var title: String { get }
}

class PickerTextField<Item: PickerSelectable>: PrimaryTextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var shouldReloadOnSetItems = true
    
    var items: [Item] = [] {
        didSet {
            pickerView.reloadComponent(0)
            guard shouldReloadOnSetItems else { return }
            if !items.isEmpty {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 0)
            }
        }
    }
    
    var selectedItem: Item?
    
    var didSelect: ((Item) -> Void)?
    var didClickReturn: ((Item) -> Void)?
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        inputView = picker
        return picker
    }()
    
    init() {
        super.init(frame: .zero)
        addDoneOnKeyboardWithTarget(self, action: #selector(done))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func done() {
        if let item = selectedItem {
            didClickReturn?(item)
        }
        resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard items.count > 0 else { return }
        let item = items[row]
        text = item.title
        selectedItem = item
        didSelect?(item)
    }
    
    // do not allow pasting
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         if action == #selector(UIResponderStandardEditActions.paste(_:)) {
             return false
         }
         return super.canPerformAction(action, withSender: sender)
    }
    
    func setSelected(_ item: Item) {
        if let index = items.firstIndex(where: { $0.title == item.title }) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
            pickerView.delegate?.pickerView?(pickerView, didSelectRow: index, inComponent: 0)
        }
    }
    
}
