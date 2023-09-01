//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    private let viewModel = HomeViewModel()
    private var newsData : NewsModel? = nil
    private var sourceList : [String?] = []
    
    private var filterView = FilterView()
    private var newsTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        return table
    }()
    
    private var searchSourceTextField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 0.5
        field.placeholder = "search for specific news here"
        return field
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchNews(key: "apple")
        prepareUI()
        setupObserver()
        self.newsTable.reloadData()
    }
    
    private func prepareUI(){
        view.backgroundColor = .white
        
        filterView.delegate = self
        searchSourceTextField.delegate = self
        
        setupCategoryFilter()
        setupNewsTable()
    }
    
    private func setupCategoryFilter(){
        view.addSubview(filterView)
        view.addSubview(searchSourceTextField)
        
        filterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(50)
        }
        
        searchSourceTextField.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(30)
            make.height.equalTo(30)
        }
    }
    
    private func setupNewsTable(){
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        
        view.addSubview(newsTable)
        newsTable.snp.makeConstraints { make in
            make.top.equalTo(searchSourceTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupObserver(){
        viewModel.onGetNews = { (sourceList) in
            self.sourceList = sourceList
            DispatchQueue.main.async(execute: {
                self.newsTable.reloadData()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.titleLabel.text = self.sourceList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = ArticlesViewController()
        target.headerTitle = self.sourceList[indexPath.row] ?? "No Header"
        navigationController?.pushViewController(target, animated: true)
    }
    
}

extension HomeViewController : FilterViewDelegate {
    func didSelectOnFilterValue(withType: String) {
        viewModel.fetchNewsWithCategory(category: withType)
    }
    
}

extension HomeViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.fetchNews(key: self.searchSourceTextField.text ?? "")
    }
}

