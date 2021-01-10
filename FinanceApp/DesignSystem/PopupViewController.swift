//
//  PopupViewController.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 05/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var popupBackgroundImage: UIImageView!
    
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var actionButton: PrimaryRoundButton!
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var secondaryButton: SecondaryRoundButton!
    
    var formTitle: String = "" {
        didSet{
            self.titleLabel.text = formTitle
        }
    }
    
    var buttonTitle: String = "" {
        didSet {
            actionButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    var secondaryButtonTitle: String = "" {
        didSet {
            secondaryButton.isHidden = false
            secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
        }
    }
    
    var buttonClicked: (() -> Void)?
    var secondaryButtonClicked: (() -> Void)?
    
    init() {
        super.init(nibName: "PopupViewController", bundle: nil)
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryButton.isHidden = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOutsideForm))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapOutsideForm() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        buttonClicked?()
    }
    
    @IBAction func secondaryButtonClicked(_ sender: Any) {
        secondaryButtonClicked?()
    }
    
    func isValidForm() -> Bool {
        let tFs = formStackView.arrangedSubviews.filter { $0 is PrimaryTextField } as? [PrimaryTextField]
        let textFieldsValidation: [Bool] = tFs?.compactMap { $0.isValidText } ?? []
        let isValid = textFieldsValidation.reduce(true) { $0 && $1 }
        
        let subStacks = formStackView.arrangedSubviews.filter { $0 is UIStackView } as? [UIStackView]
        let subStacksSubViews = subStacks?.flatMap { $0.arrangedSubviews }
        let subTfs = subStacksSubViews?.filter { $0 is PrimaryTextField } as? [PrimaryTextField]
        let subTextFieldsValidation: [Bool] = subTfs?.map { $0.isValidText } ?? []
        let isSubValid = subTextFieldsValidation.reduce(true) { $0 && $1 }
        
        let isFormValid = isValid && isSubValid
        
        if !isFormValid {
            present(message: "Por favor, preencha todos os campos obrigatórios corretamente")
        }
        
        return isFormValid
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
}
