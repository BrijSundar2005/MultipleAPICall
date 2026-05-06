//
//  NetworkLayerProtocol.swift
//  MuptipleAPICall
//
//  Created by Brij Sundar on 03/05/26.
//
import Foundation

protocol NetworkLayerProtocol {
    func callAPI<T: Decodable>(requestUrl: URL, completionHandler: @escaping(Result<T, Error>) -> Void)
}

class NetworkLayer: NetworkLayerProtocol {
    func callAPI<T>(requestUrl: URL, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0){
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(T.self, from: responseData!)
//                    _=completionHandler(result)
                    completionHandler(.success(result))
                }catch let error {
                    debugPrint("error occured while decoding =\(error.localizedDescription)")
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}
