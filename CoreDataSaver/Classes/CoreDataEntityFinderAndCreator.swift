//
//  CoreDataEntityFinderAndCreator.swift
//  Pods
//
//  Copyright © 2020 Evgenшш Ivanov. All rights reserved.
//

import Foundation
import MagicalRecord

@objc open class CoreDataEntityFinderAndCreator : NSObject {
    
    public var context: NSManagedObjectContext?
    
    public init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    open func findEntityOfType<T: NSManagedObject>(_ type: T.Type, byAttribute attr: String, withValue value: Any) -> T? {
        let obj = type.mr_findFirst(byAttribute: attr, withValue: value, in: context!)
        return obj
    }
    
    open func findEntityOfType<T: NSManagedObject>(_ type: T.Type, withPredicate predicate: NSPredicate) -> T?{
        let obj = type.mr_findFirst(with: predicate, in:context!)
        return obj
    }
    
    open func allEntitiesOfType<T: NSManagedObject>(_ type: T.Type, byAttribute attr: String, withValue value: Any) -> [T]? {
        let objs = type.mr_find(byAttribute: attr, withValue: value)
        return objs as! [T]
    }
    
    open func findFirstEntityOfType<T: NSManagedObject>(_ type: T.Type) -> T? {
        let obj = type.mr_findFirst(in: context!)
        return obj
    }
    
    open func createEntityOfType<T: NSManagedObject>(_ type: T.Type) -> T? {
        let obj = type.mr_createEntity(in: context!)
        return obj
    }
    
    open func findOrCreateEntityOfType<T: NSManagedObject>(_ type: T.Type, byAttribute attr: String, withValue value: Any) -> T {
        let obj = type.mr_findFirstOrCreate(byAttribute: attr, withValue: value, in: context!)
        return obj
    }
    
    open func countOfEntitiesOfType<T: NSManagedObject>(_ type: T.Type) -> UInt {
        let count = type.mr_countOfEntities(with: context!)
        return count
    }
}
