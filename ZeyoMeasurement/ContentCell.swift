//
//  ContentCell.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 03/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell, UITextFieldDelegate {
    
    var measurementItem: (Part, Float)! {
        didSet {
            partLabel.text = measurementItem.0.label
            lengthTextField.text = "\(measurementItem.1)"
            unitLabel.text = ApplicationSettings.Status.defaultUnit.label
        }
    }
    
    let partLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NECK"
        return label
    }()
    
    let lengthTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "\(45.2)"
        textField.textAlignment = .right
        textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()

    let unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UNIT"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContraints()
        
        lengthTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lengthTextField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let length = Float(lengthTextField.text!) {
            measurementItem.1 = length
        }
        lengthTextField.text = "\(measurementItem.1)"
        return true
    }
    
    func setupContraints() {
        contentView.preservesSuperviewLayoutMargins = true
        
        let stackView = UIStackView(arrangedSubviews: [partLabel, lengthTextField, unitLabel])
        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        // stop lengthlabel from changing size
        partLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: 0.3).isActive = true
        unitLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: 0.1).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
