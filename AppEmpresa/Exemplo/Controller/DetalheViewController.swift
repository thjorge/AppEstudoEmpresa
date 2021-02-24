//
//  DetalheViewController.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 28/01/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {

    @IBOutlet weak var voltarParaHomeButton: UIButton!
    
    @IBOutlet weak var tituloNomeEmpresaLabel: UILabel!
    
    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    
    @IBOutlet weak var descricao1TextView: UITextView!
    
    @IBOutlet weak var descricao2TextView: UITextView!
    
    var tituloNomeEmpresa: String!
    var nomeEmpresa: String!
    var descricao1: String!
    var descricao2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(voltar(tapGestureRecognizer:)))
        voltarParaHomeButton.isUserInteractionEnabled = true
        voltarParaHomeButton.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {

        self.tituloNomeEmpresaLabel.text = tituloNomeEmpresa
        self.nomeEmpresaLabel.text = nomeEmpresa
        self.descricao1TextView.text = descricao1
        self.descricao2TextView.text = descricao2
    }
    
    @objc func voltar(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
