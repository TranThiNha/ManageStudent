//
//  ClassOfStudent_+CoreDataProperties.swift
//  ManageStudent
//
//  Created by Nha T.Tran on 3/26/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ClassOfStudent_ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassOfStudent_> {
        return NSFetchRequest<ClassOfStudent_>(entityName: "ClassOfStudent_");
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var student: NSSet?

}

// MARK: Generated accessors for student
extension ClassOfStudent_ {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: Student_)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: Student_)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}
