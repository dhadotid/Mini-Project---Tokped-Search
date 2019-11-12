//
//  NetworkProvider.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

protocol NetworkProvider {
    func get(urlString: String, queryItems: [String: Any]) -> Single<Any?>
    func post(urlString: String, queryItems: [String: Any], body: [String: Any]) -> Single<Any?>
    func put(urlString: String, queryItems: [String: Any], body: [String: Any]) -> Single<Any?>
    func delete(urlString: String, queryItems: [String: Any], body: [String: Any]) -> Single<Any?>
}

extension NetworkProvider {
    func get(urlString: String, queryItems: [String: Any] = [:]) -> Single<Any?> {
        return get(urlString: urlString, queryItems: [:])
    }
    
    func post(urlString: String, queryItems: [String: Any] = [:], body: [String: Any] = [:]) -> Single<Any?> {
        return post(urlString: urlString, queryItems: queryItems, body: body)
    }
    
    func put(urlString: String, queryItems: [String: Any] = [:], body: [String: Any] = [:]) -> Single<Any?> {
        return put(urlString: urlString, queryItems: queryItems, body: body)
    }
    
    func delete(urlString: String, queryItems: [String: Any] = [:], body: [String: Any] = [:]) -> Single<Any?> {
        return delete(urlString: urlString, queryItems: queryItems, body: body)
    }
}

class NetworkClient: NetworkProvider {
    func get(urlString: String, queryItems: [String : Any]) -> Single<Any?> {
        return request(.get, urlString: urlString, queries: queryItems)
    }
    
    func post(urlString: String, queryItems: [String : Any], body: [String : Any]) -> Single<Any?> {
        return request(.post, urlString: urlString, queries: queryItems, body: body)
    }
    
    func put(urlString: String, queryItems: [String : Any], body: [String : Any]) -> Single<Any?> {
        return request(.put, urlString: urlString, queries: queryItems, body: body)
    }
    
    func delete(urlString: String, queryItems: [String : Any], body: [String : Any]) -> Single<Any?> {
        return request(.delete, urlString: urlString, queries: queryItems, body: body)
    }
    
     func request(_ method: Alamofire.HTTPMethod, urlString: String, queries: [String: Any]? = nil, body: [String: Any]? = nil, headers: HTTPHeaders? = nil) -> Single<Any?> {
        guard let url = URL(string: urlString) else { return Single.error(NetworkError.invalidUrl) }
        return Single.create { single -> Disposable in
            let urlEncoding = RequestEncoding(queries: queries, body: body)
            let request = AF.request(url, method: method, encoding: urlEncoding)
                .validate(statusCode: 200..<300)
                .response(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                        single(.success(jsonObject))
                    }
                    else {
                        single(.success(data))
                    }
                case .failure(let error):
                    do {
                        if let data = response.data,
                            let errorObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                            let response = try Mapper<TokpedResponse>().tryMap(JSONObject: errorObject)
                            var gfError = response.status
                            gfError?.httpStatusCode = error.asAFError?.responseCode
                            // Throws if it's valid gfError
                            if let gfError = gfError {
                                throw gfError
                            }
                        }
                        throw TokpedError(error: error)
                    } catch {
                        single(.error(error))
                    }
                }
            })
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
