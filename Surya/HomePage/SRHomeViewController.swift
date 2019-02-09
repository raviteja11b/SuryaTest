//
//  HomeViewController.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class SRHomeViewController: UIViewController {
    let viewModel = SRUsersViewModel.init()
    private let bag = DisposeBag()
    @IBOutlet weak var usersListTableView: UITableView!
    @IBOutlet weak var progresLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserEmailId()
        bindTableView()
        bindViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
extension SRHomeViewController{
    func checkForUserEmailId(){
        if !viewModel.userEmailExists {
            let alert = UIAlertController.init(title: "Enter Email Id", message: "", preferredStyle: .alert)
            var txtField : UITextField!
            alert.addTextField { (field) in
                field.placeholder = "Email Id"
                field.textContentType = UITextContentType.emailAddress
                txtField = field
            }
            
            let submitAction = UIAlertAction.init(title: "Submit", style: .default) {[weak self] (action) in
                self?.requestForRefresh(withEmail: alert.textFields?[0].text ?? "")
            }
            
            txtField.rx.text.asObservable().subscribe(onNext: { (email) in
                //validate email id
                if let id = email, id.contains("@"){
                    submitAction.isEnabled = true
                }else{
                    submitAction.isEnabled = false
                }
            }).disposed(by: bag)
            alert.addAction(submitAction)
            present(alert, animated: true, completion: nil)
            
        }else{
            requestForRefresh()
        }
        
    }
    
    func requestForRefresh(withEmail email : String){
        viewModel.requestForData(forEmail: email)
    }
    func requestForRefresh(){
        viewModel.requestForData()
    }
}

extension SRHomeViewController{
    func bindViews(){
        viewModel.isLoading.asObservable().subscribe(onNext: {[weak self] (status) in
            //changing progress label based on Api request
            let completionMessage = "Data has been Updated"
            let progressMessage = "Data is Updating please wait"
            if let label = self?.progresLabel, label.text == progressMessage, !status{
                label.text = completionMessage
                
                //Animating label
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    label.text = ""
                })
            }else{
                self?.progresLabel?.text = status ? progressMessage : ""
            }
        }).disposed(by: bag)
    }
}

extension SRHomeViewController{
    func bindTableView(){
        viewModel.usersList.asObservable().bind(to: usersListTableView.rx.items(cellIdentifier: "UserCell", cellType: SRUserTableViewCell.self)){ (row, item, cell) in
            cell.setupCell(forUser: item)
            }.disposed(by: bag)
    }
}

