//
//  APIManager_2.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/10/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import Foundation

class APIManager_2: NSObject {
    var complitionHandler:((Data) -> Void)!
    func retriveData(url:URL, complitionHandler:@escaping (Data) -> Void) {
        self.complitionHandler = complitionHandler
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let request = URLRequest(url: url)
        let dataTask = session.downloadTask(with: request)
        dataTask.resume()
    }
}

extension APIManager_2:URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data = try Data(contentsOf: location, options: [])
            DispatchQueue.main.async {
                self.complitionHandler(data)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
