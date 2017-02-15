//
//  PhotoObject+CoreDataProperties.swift
//  20170215 Quote Pro
//
//  Created by Minhung Ling on 2017-02-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension PhotoObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoObject> {
        return NSFetchRequest<PhotoObject>(entityName: "PhotoObject");
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var quote: QuoteObject?

}
