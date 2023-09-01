//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    
    var webViewURL : String = ""
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        // Do any additional setup after loading the view.
    }
    
    private func prepareUI(){
        view.backgroundColor = .white

        self.view.addSubview(webView)
        webView.snp.makeConstraints { webViewConstraints in
            webViewConstraints.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            webViewConstraints.leading.equalTo(self.view).offset(15)
            webViewConstraints.trailing.equalTo(self.view).inset(15)
            webViewConstraints.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        setupWebViewContent()
    }
    

    private func setupWebViewContent() {
        guard webViewURL != "" else {
            print("webViewURL should not be empty")
            return
        }

        if let url = URL(string: webViewURL) {
            webView.load(URLRequest(url: url))
        } else {
            print("webViewURL not valid")
        }
    }
}

extension ArticleDetailViewController: WKNavigationDelegate {
    public func onBackNavigation(_ sender: UIBarButtonItem!) {
        navigationController?.dismiss(animated: false)
    }
}

extension ArticleDetailViewController {
    func setWebViewURL(_ url: String) {
        webViewURL = url
    }
}

