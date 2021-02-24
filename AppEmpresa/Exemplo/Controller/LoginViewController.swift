//
//  ViewController.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 28/01/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var entrarButton: UIButton!
    
    @IBOutlet weak var iconEyeLogin: UIImageView!
    
    @IBOutlet weak var stackViewLogoTitulo: UIStackView!
    
    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var constraintStackView: NSLayoutConstraint!
    
    @IBOutlet weak var erroEmailImage: UIImageView!
    
    @IBOutlet weak var erroSenhaImage: UIImageView!
    
    @IBOutlet weak var textoCredencialIncorretaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        
        //Code for left padding
        Shared.sharedInstance.textFieldLeftPadding(textFieldName:usuarioTextField)
        
        Shared.sharedInstance.textFieldLeftPadding(textFieldName:senhaTextField)
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        entrarButton.layer.cornerRadius = 8
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        iconEyeLogin.isUserInteractionEnabled = true
        iconEyeLogin.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        senhaTextField.isSecureTextEntry.toggle()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -100
        
        if self.constraintStackView.constant == 38 {
            self.constraintStackView.constant += 114
            self.labelTitulo.isHidden = true
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
        
        self.constraintStackView.constant = 38
        self.labelTitulo.isHidden = false
    }
    
    func validateFields() -> Bool {
        var valid = true
        let trimmedUsuario = self.usuarioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSenha = self.senhaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedUsuario!.isEmpty || !Email.isValidEmail(trimmedUsuario!)) {
            valid = false
        } else if (trimmedSenha!.isEmpty) {
            valid = false
        }
        
        return valid
    }
    
    func formatarCampos() {
        self.erroEmailImage.isHidden = false
        self.erroSenhaImage.isHidden = false
        self.iconEyeLogin.isHidden = true
        self.textoCredencialIncorretaLabel.isHidden = false
        
        self.usuarioTextField.layer.cornerRadius = 4.0
        self.usuarioTextField.layer.masksToBounds = true
        self.usuarioTextField.layer.borderColor = UIColor( red: 220/255, green: 20/255, blue:60/255, alpha: 1.0 ).cgColor
        self.usuarioTextField.layer.borderWidth = 1.0
        
        self.senhaTextField.layer.cornerRadius = 4.0
        self.senhaTextField.layer.masksToBounds = true
        self.senhaTextField.layer.borderColor = UIColor( red: 220/255, green: 20/255, blue:60/255, alpha: 1.0 ).cgColor
        self.senhaTextField.layer.borderWidth = 1.0
    }
    
    @IBAction func entrarButtonClicked(_ sender: Any) {

        if !validateFields() {
            formatarCampos()
            return
        }
        
        let width = view.frame.width/2 - 36
        let height = view.frame.height/2 - 36
        
        let ind = MyIndicator(frame: CGRect(x: width, y: height, width: 72, height: 72), image: UIImage(named: "indicator")!)
        view.addSubview(ind)
        ind.startAnimating()
        let usuario: String = self.usuarioTextField.text!
        let senha: String = self.senhaTextField.text!
        let authDictionary: [String: Any] = ["email": usuario, "password": senha]
        
        EmpresaAPI.logar(authDictionary: authDictionary) {  (response, error, cache) in
        
            if response != nil {
                
                let header = UserDefaults.standard.dictionary(forKey: "authenticationHeaders")
                
                print("valores \(header!["access-token"]!) + \(header!["client"]!) + \(header!["uid"]!)")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                homeViewController.modalPresentationStyle = .fullScreen
                self.present(homeViewController, animated: true, completion: nil)
                ind.stopAnimating()
            } else if let error = error {
                if let urlResponse = error.urlResponse, urlResponse.statusCode == 401 {
                    // logout user
                    self.formatarCampos()
                    
                } else if let responseObject = error.responseObject as? [String: Any], let errorMessage = responseObject["error_message"] {
                    // show errorMessage
                } else {
                    // show error.originalError.localizedDescription
                }
                ind.stopAnimating()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
