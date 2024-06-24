//
//  APICaller.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 02/06/2024.
//

import Foundation

protocol Network: AnyObject {
    var url: URL? {get set}
    var requeset: URLRequest? {get set}
    
}

enum APIError: Error {
    case failedData
}

struct Constant {
    static let youtubeAPI = "AIzaSyCWpKF8Ydy1mhg0ok5Oh8c3O8NI845HjXE"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller: Network {
    
    
    
    static let  shared = APICaller()
    var url: URL?
    var requeset: URLRequest?

    
    func sendRequest(complition: @escaping (Result<[Movie], Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "kinopoiskapiunofficial.tech"
        urlComponents.path = "/api/v2.2/films"
        
        self.url = urlComponents.url
        
        if let url = url {
            requeset = URLRequest(url: url)
            requeset?.httpMethod = "GET"
            requeset?.setValue("b7659ec1-921b-4ad2-a568-b32ba2e3df61", forHTTPHeaderField: "x-api-key")
            requeset?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            URLSession.shared.dataTask(with: requeset!) { data, responsce, err in
                guard let data = data, err == nil else {
                    print(err!.localizedDescription)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    complition(.success(result.items))
                }catch{
                    complition(.failure(APIError.failedData))
                }
            }.resume()
        }
        
    }
    
    func getMovie(with q: String, complition: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let q = q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.YoutubeBaseURL)q=\(q)&key=\(Constant.youtubeAPI)") else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponce.self, from: data)
                print(result)
                complition(.success(result.items[0]))

            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

