//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation
import UIKit

class ArticlesViewController: UIViewController {
    
    let viewModel = ArticlesViewModel()
    private var articleData : NewsModel? = nil
    
    var headerTitle = "No Header"
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var articlesTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchNews(source: headerTitle)
        prepareUI()
        setupObserver()
    }
    
    private func prepareUI(){
        view.backgroundColor = .white
        
        prepareHeader()
        setupArticlesTable()
    }
    
    private func prepareHeader(){
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(50)
        }
        
        headerLabel.text = "\(headerTitle) Articles"
    }
    
    private func setupArticlesTable(){
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(NewsCell.self, forCellReuseIdentifier: "ArticlesCell")
        
        view.addSubview(articlesTable)
        articlesTable.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupObserver(){
        viewModel.onGetArticles = { (articleList) in
            self.articleData = articleList
            DispatchQueue.main.async(execute: {
                self.articlesTable.reloadData()
            })
        }
    }
}

extension ArticlesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleData?.articlesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.titleLabel.text = self.articleData?.articlesData?[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("web Url \(self.articleData?.articlesData?[indexPath.row].url)")
        let target = ArticleDetailViewController()
        target.setWebViewURL(self.articleData?.articlesData?[indexPath.row].url ?? "apple.com")
        
        navigationController?.pushViewController(target, animated: true)
    }

}
