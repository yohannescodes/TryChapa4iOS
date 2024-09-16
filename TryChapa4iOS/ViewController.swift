//
//  ViewController.swift
//  TryChapa4iOS
//
//  Created by Yohannes Aklilu Haile on 9/16/24.
//


import UIKit
import Chapa4iOS
import WebKit


class ViewController: UIViewController {
    
    var checkoutURL: URL?
    var chapa: Chapa!
    var transaction = ""
    
    private let payBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Test Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chapa = Chapa(secretKey: "PUT YOUR SECRET KEY HERE")
        view.addSubview(payBtn)
        
        payBtn.addTarget(self, action: #selector(didTapPayBtn), for: .touchUpInside)

        self.applyConstraints()
        
    }
    
    
    private func applyConstraints(){
        payBtn.translatesAutoresizingMaskIntoConstraints = false

        
        let payBtnConstraints = [
            payBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            payBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            payBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            payBtn.heightAnchor.constraint(equalToConstant: 60)
        ]

        
        NSLayoutConstraint.activate(payBtnConstraints)
         
    }
    
    @objc func didTapPayBtn(){
        transaction = chapa.generateTransactionReference()
        let customer = Customer(amount: "100", currency: .etb, email: nil, firstName: "Steve", lastName: "Jobs", phoneNumber: "0900123456", txRef: transaction, callbackURL: nil, returnURL: nil, customization: ChapaCustomization(title: "Hello", description: "Welcome to Chapa4iOS POC"))
        
        chapa.acceptPayment(controller: self, customer: customer)
    }
}




