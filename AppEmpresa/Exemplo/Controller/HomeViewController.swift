//
//  HomeViewController.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 02/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nomeEmpresaTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageBack: UIImageView!
    
    @IBOutlet weak var labelResultadoEncontrado: UILabel!

    @IBOutlet weak var semResultado: UILabel!
    
    var authenticationAPI: EmpresaAPI?
    
    var empresas: [Enterprise] = []
    
    var empresasPesquisadas: [Enterprise] = []
    
    let cellSpacingHeight: CGFloat = 5
    
    var imageViewLogoHome1: UIImageView?
    var imageViewLogoHome2: UIImageView?
    var imageViewLogoHome3: UIImageView?
    var imageViewLogoHome4: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelResultadoEncontrado.isHidden = true
        self.semResultado.isHidden = false
        
        let imageNameLogoHome4 = "logo_home_4.png"
        let imageLogoHome4 = UIImage(named: imageNameLogoHome4)
        imageViewLogoHome4 = UIImageView(image: imageLogoHome4!)
        imageViewLogoHome4!.frame = CGRect(x: -5, y: 70, width: 117, height: 140)
        self.imageBack.addSubview(imageViewLogoHome4!)

        let imageNameLogoHome2 = "logo_home_2.png"
        let imageLogoHome2 = UIImage(named: imageNameLogoHome2)
        imageViewLogoHome2 = UIImageView(image: imageLogoHome2!)
        imageViewLogoHome2!.frame = CGRect(x: 30, y: 0, width: 258, height: 191)
        self.imageBack.addSubview(imageViewLogoHome2!)

        let imageNameLogoHome3 = "logo_home_3.png"
        let imageLogoHome3 = UIImage(named: imageNameLogoHome3)
        imageViewLogoHome3 = UIImageView(image: imageLogoHome3!)
        imageViewLogoHome3!.frame = CGRect(x: 275, y: 10, width: 101, height: 125)
        self.imageBack.addSubview(imageViewLogoHome3!)
        
        let imageNameLogoHome1 = "logo_home_1.png"
        let imageLogoHome1 = UIImage(named: imageNameLogoHome1)
        imageViewLogoHome1 = UIImageView(image: imageLogoHome1!)
        imageViewLogoHome1!.frame = CGRect(x: 200, y: 80, width: 141, height: 125)
        self.imageBack.addSubview(imageViewLogoHome1!)
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.nomeEmpresaTextField?.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
    
        self.view.frame.origin.y = -100
        imageViewLogoHome1!.isHidden = true
        imageViewLogoHome2!.isHidden = true
        imageViewLogoHome3!.isHidden = true
        imageViewLogoHome4!.isHidden = true
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
        imageViewLogoHome1!.isHidden = false
        imageViewLogoHome2!.isHidden = false
        imageViewLogoHome3!.isHidden = false
        imageViewLogoHome4!.isHidden = false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        
        buscarEmpresas(textField: textfield)
        
    }
    
    func buscarEmpresas(textField: UITextField) {
        
        let width = view.frame.width/2 - 36
        let height = view.frame.height/2 - 36
        
        let ind = MyIndicator(frame: CGRect(x: width, y: height, width: 72, height: 72), image: UIImage(named: "indicator")!)
        view.addSubview(ind)
        ind.startAnimating()
        
        EmpresaAPI.buscarEmpresas() {  (response, error, cache) in
        
            if let response = response {

                self.empresas = response.enterprises
        
                self.empresasPesquisadas.removeAll()
                if textField.text?.count != 0 {
                    for empresa in self.empresas {
                        
                        let fullName = empresa.enterprise_name
                        let fullNameArr = fullName!.split{$0 == " "}.map(String.init)
                        
                        let range = fullNameArr[0].lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil,   locale: nil)
                        
                        if range != nil {
                            self.empresasPesquisadas.append(empresa)
                        }
                    }
                    
                    if(self.empresasPesquisadas.count>0) {
                        self.labelResultadoEncontrado.isHidden = false
                        self.labelResultadoEncontrado.text = "\(self.empresasPesquisadas.count) resultado (s) encontrado (s)"
                        self.semResultado.isHidden = true
                    } else {
                        self.semResultado.isHidden = false
                        self.labelResultadoEncontrado.isHidden = true
                    }
                    
                } else {
                    self.semResultado.isHidden = false
                    self.labelResultadoEncontrado.isHidden = true
                    self.empresasPesquisadas.removeAll()
                }

                self.tableView.reloadData()
                
            } else if let error = error {
                if let urlResponse = error.urlResponse, urlResponse.statusCode == 401 {
                    // logout user
                } else if let responseObject = error.responseObject as? [String: Any], let errorMessage = responseObject["error_message"] {
                    // show errorMessage
                } else {
                    // show error.originalError.localizedDescription
                }
            }
            ind.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.empresasPesquisadas.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "enterpriseId") as! EnterpriseTableViewCell

        let position = indexPath.section
        if position<self.empresasPesquisadas.count {
            
            let fullName = self.empresasPesquisadas[position].enterprise_name
            let fullNameArr = fullName!.split{$0 == " "}.map(String.init)
            
            let empresaPesq = fullNameArr[0]
            
            cell.nomeEmpresa.text = empresaPesq
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.section
        let empresaEscolhida = self.empresasPesquisadas[position]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detalheViewController = storyBoard.instantiateViewController(withIdentifier: "DetalheViewController") as! DetalheViewController
        detalheViewController.tituloNomeEmpresa = empresaEscolhida.enterprise_name
        detalheViewController.nomeEmpresa = empresaEscolhida.enterprise_name
        detalheViewController.descricao1 = empresaEscolhida.description
        detalheViewController.descricao2 = empresaEscolhida.description
        detalheViewController.modalPresentationStyle = .fullScreen
        self.present(detalheViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
