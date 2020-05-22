//
//  CoreDataRemover.swift
//  Pods
//
//  Copyright © 2020 Evgenii Ivanov. All rights reserved.
//

import Foundation
import MagicalRecord

@objc open class CoreDataRemover: NSObject {

    public static func truncateAllOfTypes(_ managedObjectTypes: [NSManagedObject.Type], inContext context: NSManagedObjectContext) {
        for moType in managedObjectTypes {
            moType.mr_truncateAll(in: context)
        }
    }
}
