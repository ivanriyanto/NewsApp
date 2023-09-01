//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation

final class HomeViewModel {
    
    internal var onGetNews: (([String?]) -> Void)?
    
    var newsAPIService: NewsServiceable
    init(newsAPIService: NewsServiceable = NewsAPIService()){
        self.newsAPIService = newsAPIService
    }
    
    func fetchNews(key: String){
        newsAPIService.fetchNews(key: key) { [weak self] result in
            switch result {
            case .success(let data):
                let mappedModel : NewsModel = try! JSONDecoder().decode(NewsModel.self, from: data) as NewsModel
                let sourceList = self?.generateSourcesList(data: mappedModel)
                if let onGetNews = self?.onGetNews {
                    onGetNews(sourceList ?? [])
                }
            case .failure(let error):
                print("===== \(error)")
            }
        }
    }
    
    func fetchNewsWithCategory(category: String){
        newsAPIService.fetchNewsWithCategory(category: category, callback: { [weak self] result in
            switch result {
            case .success(let data):
                let mappedModel : NewsSourceModel = try! JSONDecoder().decode(NewsSourceModel.self, from: data) as NewsSourceModel
                let sourceList = self?.generateSourcesListFromCategory(data: mappedModel)
                print("data \(mappedModel)")
                if let onGetNews = self?.onGetNews {
                    onGetNews(sourceList ?? [])
                }
            case .failure(let error):
                print("===== \(error)")
            }

        })
    }

    private func generateSourcesList(data: NewsModel) -> [String?]{
        var sourcesArray = [String]()
        let counter = data.articlesData?.count ?? 0

        for index in 0..<counter {
            if let sourceName = data.articlesData?[index].sourceData.sourceName, !sourcesArray.contains(sourceName) {
                sourcesArray.append(sourceName)
            }
        }
        
        return sourcesArray
    }
    
    private func generateSourcesListFromCategory(data: NewsSourceModel) -> [String?]{
        var sourcesArray = [String]()
        let counter = data.sources?.count ?? 0

        for index in 0..<counter {
            if let sourceName = data.sources?[index].sourceName, !sourcesArray.contains(sourceName) {
                sourcesArray.append(sourceName)
            }
        }
        
        return sourcesArray
    }
}
