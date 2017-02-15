//
//  QuoteManager.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class QuoteManager: NSObject {
    
    var quoteObject: QuoteObject?
    var photoObject: PhotoObject?
    
    static let sharedInstance = QuoteManager()
    private override init() {
    }
    
    func generateObjects () {
        quoteObject = DataManager.sharedInstance.generateQuoteObject()
        photoObject = DataManager.sharedInstance.generatePhotoObject()
    }
    
    func generateQuote (completion: @escaping (_ quote:String) -> Void) {
        if quoteObject == nil && photoObject == nil {
            generateObjects()
        }
        guard let quoteObject = quoteObject else {
            return
        }
        let url = URL.init(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,String> else {
                print("data returned is not json, or not valid")
                OperationQueue.main.addOperation {
                    self.defaultQuote()
                    if let quote = self.createQuote() {
                        completion(quote)
                    }
                }
                return
            }
            guard let quoteText = json["quoteText"], let quoteAuthor = json["quoteAuthor"] else {
                OperationQueue.main.addOperation {
                    self.defaultQuote()
                    if let quote = self.createQuote() {
                        completion(quote)
                    }
                }
                return
            }
            quoteObject.quote = quoteText
            quoteObject.author = quoteAuthor
            OperationQueue.main.addOperation {
                if let quote = self.createQuote() {
                    completion(quote)
                }
            }
        }
        task.resume()
    }
    
    func generateImage (completion: @escaping (_ image: UIImage) -> Void) {
        if quoteObject == nil && photoObject == nil {
            generateObjects()
        }
        guard let photoObject = photoObject else {
            return
        }
        
        let url = URL.init(string: "http://lorempixel.com/350/600/")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                photoObject.photo = UIImagePNGRepresentation(#imageLiteral(resourceName: "patience")) as NSData?
                OperationQueue.main.addOperation {
                    completion(#imageLiteral(resourceName: "patience"))
                }
                return
            }
            let image = UIImage(data: data)
            photoObject.photo = data as NSData?
            OperationQueue.main.addOperation {
                if let image = image {
                    completion(image)
                }
            }
        }
        task.resume()
    }
    
    func saveQuote() {
        NotificationCenter.default.post(name: NSNotification.Name("saveQuote"), object: nil)
        DataManager.sharedInstance.saveContext()
    }
    
    
    func defaultQuote() {
        guard let quoteObject = quoteObject else {
            return
        }
        quoteObject.quote = "Patience is not about how long you wait but how you behave while waiting"
        quoteObject.author = "Joyce Meyer"
    }
    
    func createQuote() -> String? {
        guard let quoteObject = quoteObject, let quote = quoteObject.quote, let author = quoteObject.author else {
            return nil
        }
        let capText = quote.uppercased()
        return "\"\(capText)\"\n-\(author)"
    }
}
