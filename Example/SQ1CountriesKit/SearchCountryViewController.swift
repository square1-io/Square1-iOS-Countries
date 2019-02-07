//
//  SearchCountryViewController.swift
//  Riide
//
//  Created by Ricardo Antolin on 30/01/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

import UIKit
import SQ1CountriesKit

class SearchCountryViewController: UIViewController {
    
    struct CountriesList {
        let selected: Country?
        let completeList: [Country]
    }
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var items: CountriesList!{
        didSet{
            itemsFiltered = items
        }
    }
    var itemsFiltered: CountriesList = CountriesList(selected: nil, completeList: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        self.items = CountriesList(selected: nil, completeList: Countries.getCountryList())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: CountryItemTableViewCell.nibName,
                  bundle: nil),
            forCellReuseIdentifier: CountryItemTableViewCell.identifier)
        txtSearch.delegate = self
        txtSearch.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchCountryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 1
        
        if itemsFiltered.selected != nil {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section {
        case 0:
            if itemsFiltered.selected != nil {
                rows = 1
            }else {
                rows = itemsFiltered.completeList.count
            }
        default:
            rows = itemsFiltered.completeList.count
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: CountryItemTableViewCell.identifier) as? CountryItemTableViewCell
        
        switch indexPath.section {
        case 0:
            if let selected = itemsFiltered.selected {
                cell?.bindCountry(selected, selected: true)
            } else {
                cell?.bindCountry(itemsFiltered.completeList[indexPath.row])
            }
        default:
            cell?.bindCountry(itemsFiltered.completeList[indexPath.row])
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.items = CountriesList(
            selected: itemsFiltered.completeList[indexPath.row],
            completeList: Countries.getCountryList())
        self.tableView.reloadData()
    }
}

extension SearchCountryViewController: UITableViewDelegate {
    
}

extension SearchCountryViewController: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        filterCountriesByName(txtSearch.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        filterCountriesByName(textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    private func filterCountriesByName(_ name: String?){
        if let name = name, !name.isEmpty {
            self.itemsFiltered = CountriesList(
                selected: self.items.selected,
                completeList: self.items.completeList
                    .filter{ $0.name?.lowercased().contains(name.lowercased()) ?? false }
            )
        }else {
            self.itemsFiltered = self.items
        }
        self.tableView.reloadData()
    }
}
