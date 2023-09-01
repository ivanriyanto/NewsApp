//
//  Model.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation

struct NewsModel: Codable {
    let status: String?
    let total: Int?
    let articlesData : [ArticlesModel]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case total = "totalResults"
        case articlesData = "articles"
    }
}

struct ArticlesModel: Codable {
    let sourceData: SourcesModel
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage : String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case sourceData = "source"
        case author, title , description, url, urlToImage, publishedAt, content
    }
}

struct SourcesModel: Codable {
    let sourceId: String?
    let sourceName: String?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "id"
        case sourceName = "name"
    }
}


struct NewsSourceModel: Codable {
    let status: String?
    let sources : [SourcesData]?
    
    enum CodingKeys: String, CodingKey {
        case status, sources
    }
}

struct SourcesData: Codable {
    let sourceId: String?
    let sourceName: String?
    let sourceDescription: String?
    let sourceUrl: String
    let sourceCategory: String
    let sourceLanguage: String
    let sourceCountry: String
    
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "id"
        case sourceName = "name"
        case sourceDescription = "description"
        case sourceUrl = "url"
        case sourceCategory = "category"
        case sourceLanguage = "language"
        case sourceCountry = "country"
    }
}


enum NewsErrorModel: Error {
    case networkError
    case decodingError
}
