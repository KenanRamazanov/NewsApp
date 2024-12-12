//
//  APICaller.swift
//  NewsApp
//
//  Created by Kanan  on 12.12.24.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=d2aa5f20c049474d93919a98ff00c02f")
    }
    private init () {}
        public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void) {
            
            guard let url = Constants.topHeadlineURL else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if  let error = error {
                    completion(.failure(error))
                }
                
                else if let data = data  {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        print("Articles: \(result.articles.count)")
                    }
                    catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
}


//Models

struct APIResponse: Codable {
    let articles: [Article]
}


struct Article: Codable {
    let source : Source
    let title: String
//    let url: String
//    let urlToImage: String
    let description: String
//    let publishedAt: String
}


struct Source: Codable {
    let name: String
}
