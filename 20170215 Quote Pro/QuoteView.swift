//
//  QuoteView.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    let quoteManager:QuoteManager
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteImage: UIImageView!
    
required init?(coder aDecoder: NSCoder) {
        quoteManager = QuoteManager.sharedInstance
        super.init(coder: aDecoder)
    }
    
    class func initFromNib() -> QuoteView {
        let nib = UINib(nibName: "QuoteView", bundle: nil)
        let quoteView = nib.instantiate(withOwner: nil, options: nil)[0] as! QuoteView
        return quoteView
    }

    @IBAction func newQuote(_ sender: Any) {
        quoteManager.generateQuote(completion:{ (quote) in
            self.quoteLabel.text = quote
        })
    }
    
    @IBAction func newImage(_ sender: Any) {
        quoteManager.generateImage(completion: { (image) in
           self.quoteImage.image = image
        })
    }
    
    @IBAction func saveQuote(_ sender: Any) {
        quoteManager.saveQuote()
    }
}
