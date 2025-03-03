//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Kalyan Chakravarthy Narne on 2/27/25.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    private lazy var countryView: UIView = {
        let countryView = UIView()
        countryView.layer.cornerRadius = 10
        countryView.layer.borderColor = UIColor.red.cgColor
        countryView.layer.borderWidth = 3
        countryView.translatesAutoresizingMaskIntoConstraints = false
        countryView.clipsToBounds = true
        countryView.layer.shadowColor = UIColor.black.cgColor
        countryView.layer.shadowOpacity = 0.2
        countryView.layer.shadowOffset = CGSize(width: 0, height: 2)
        countryView.layer.shadowRadius = 4
        return countryView
    }()
    
    private lazy var countryRegionCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.font.helveticaBold, size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var capitalName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.font.helveticaBold, size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        backgroundColor = .clear
        configureCountryView()
        configureCapitalName()
        configureCountryRegionCode()
        
    }
    
    func setUp(with country: Country) {
        capitalName.text = country.capital
        countryRegionCode.text = (country.name ?? " ") + ", " + (country.region ?? " ") + "  " + (country.code ?? " ")
    }
    
   
    private func configureCountryView() {
        addSubview(countryView)
        NSLayoutConstraint.activate([
            countryView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            countryView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            countryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func configureCapitalName() {
           countryView.addSubview(capitalName)
           NSLayoutConstraint.activate([
               capitalName.leadingAnchor.constraint(equalTo: countryView.leadingAnchor, constant: 15),
               capitalName.topAnchor.constraint(equalTo: countryView.centerYAnchor, constant: 5),
               capitalName.trailingAnchor.constraint(equalTo: countryView.trailingAnchor, constant: -10)
           ])
       }
       
       private func configureCountryRegionCode() {
           countryView.addSubview(countryRegionCode)
           NSLayoutConstraint.activate([
               countryRegionCode.leadingAnchor.constraint(equalTo: countryView.leadingAnchor, constant: 15),
               countryRegionCode.bottomAnchor.constraint(equalTo: countryView.centerYAnchor, constant: -5),
               countryRegionCode.trailingAnchor.constraint(equalTo: countryView.trailingAnchor, constant: -10)
           ])
       }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

