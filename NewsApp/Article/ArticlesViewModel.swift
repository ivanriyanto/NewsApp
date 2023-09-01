//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation

final class ArticlesViewModel {
    
    internal var onGetArticles: ((NewsModel) -> Void)?
    
    var newsAPIService: ArticlesServiceable
    init(newsAPIService: ArticlesServiceable = NewsAPIService()){
        self.newsAPIService = newsAPIService
    }
    
    func fetchNews(source: String){
        let convertedSource = source.replacingOccurrences(of: " ", with: "-")
        print("source \(source)")
        newsAPIService.fetchArticles(domain: convertedSource) { [weak self] result in
            switch result {
            case .success(let data):
                let mappedModel : NewsModel = try! JSONDecoder().decode(NewsModel.self, from: data) as NewsModel
                print("data \(mappedModel)")
                if let onGetArticles = self?.onGetArticles {
                    onGetArticles(mappedModel)
                }
            case .failure(let error):
                print("===== \(error)")
            }
        }
    }

}

