//
//  QuoteObject+CoreDataProperties.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension QuoteObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteObject> {
        return NSFetchRequest<QuoteObject>(entityName: "QuoteObject");
    }

    @NSManaged public var author: String?
    @NSManaged public var quote: String?
    @NSManaged public var photo: PhotoObject?

}
