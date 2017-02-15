//
//  MakeQuoteViewController.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class MakeQuoteViewController: UIViewController {
    var quote: String?
    var author: String?
    var image: UIImage?
    let quoteView: QuoteView
    
    required init?(coder aDecoder: NSCoder) {
        quoteView = QuoteView.initFromNib()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(saveQuote), name: NSNotification.Name("saveQuote"), object: nil)
        view.addSubview(quoteView)
        quoteView.frame = view.frame
        if quote == nil {
            makeQuote()
            makeImage()
        }
    }
    
    func makeQuote() {
        let url = URL.init(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,String> else {
                print("data returned is not json, or not valid")
                OperationQueue.main.addOperation {
                    self.quoteView.quoteLabel.text = "\"PATIENCE IS NOT ABOUT HOW LONG YOU WAIT BUT HOW YOU BEHAVE WHILE WAITING\""
                }
                return
            }
            guard let quoteText = json["quoteText"], let quoteAuthor = json["quoteAuthor"] else {
                print("Could not produce quote")
                return
            }
            self.quote = quoteText
            self.author = quoteAuthor
            let capText = quoteText.uppercased()
            OperationQueue.main.addOperation {
                self.quoteView.quoteLabel.text = "\"\(capText)\"\n-\(quoteAuthor)"
            }
        }
        task.resume()
    }
    
    func makeImage() {
        let url = URL.init(string: "http://lorempixel.com/350/600/")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                OperationQueue.main.addOperation {
                    self.quoteView.quoteImage.image = UIImage.init(named: "patience")
                }
                return
            }
            let image = UIImage(data: data)
            self.image = image
            
            OperationQueue.main.addOperation {
                if let image = image {
                    self.quoteView.quoteImage.image = image
                }
            }
        }
        task.resume()
    }
    
    func saveQuote() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
