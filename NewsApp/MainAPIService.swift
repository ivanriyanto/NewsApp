//
//  MainAPIService.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation

protocol NewsServiceable {
    func fetchNews(key:String, callback: @escaping Handler)
    func fetchNewsWithCategory(category: String, callback: @escaping Handler)
}

protocol ArticlesServiceable {
    func fetchArticles(domain: String, callback: @escaping Handler)
}

final class NewsAPIService: Requestable, NewsServiceable, ArticlesServiceable {
    
    var apiKey: String = "9d5053290a8b45b2ba4b22cb2f40d628"
    let baseUrl = "https://newsapi.org/v2/"
    
    func fetchNews(key: String, callback: @escaping Handler) {
        let url = baseUrl + "everything?q=\(key)&apiKey="
        request(urlString: url + apiKey,
                method: "GET") { (result) in
            callback(result)
        }
    }
    
    func fetchNewsWithCategory(category: String, callback: @escaping Handler) {
        let  url = baseUrl + "top-headlines/sources?category=\(category)&apiKey="
        request(urlString: url + apiKey,
                method: "GET") { (result) in
            callback(result)
        }
    }
    
    func fetchArticles(domain: String, callback: @escaping Handler) {
        let  url = baseUrl + "everything?sources=\(domain)&apiKey="
        request(urlString: url + apiKey,
                method: "GET") { (result) in
            callback(result)
        }
    }
    
}


//extension FinCalAPIMockService: CalculateTotalMonthServiceable{
//
//    func postCalculateTotalMonth(futureValue: Int,
//                                 initialDeposit: Int,
//                                 annualInterestRate: Int,
//                                 monthlyPayment: Int,
//                                 callback: @escaping Handler) {
//        mockTotalMonthRequest { result in
//            callback(result)
//        }
//    }
//
//    func mockTotalMonthMessageToData(params: [String:Any], mockResponseResult: Int?) -> Data?{
//        let mockDataJson = try? JSONSerialization.data(withJSONObject: ["total_month" : totalMonthMessageResponse], options: .prettyPrinted)
//        return mockDataJson
//    }
//
//    func mockTotalMonthRequest(callback: @escaping Handler){
//        var mockResult: Result<Data>
//        if expectedResult == .SUCCESS {
//            mockResult = .success(mockTotalMonthMessageToData(params: monthlyPaymentParam, mockResponseResult:totalMonthMessageResponse)!)
//        } else {
//            mockResult = .failure(mockTotalMonthMessageToData(params: monthlyPaymentParam, mockResponseResult: nil)!)
//        }
//        callback(mockResult)
//    }
//}
