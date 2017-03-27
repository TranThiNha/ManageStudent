//
//  Student_+CoreDataProperties.swift
//  ManageStudent
//
//  Created by Nha T.Tran on 3/26/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Student_ {

    @nonobjc public class func fetchRequest() -> 	NSFetchRequest<Student_> {
        return NSFetchRequest<Student_>(entityName: "Student_");
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String?
    @NSManaged public var otherInfor: String?
    @NSManaged public var inClass: ClassOfStudent_?
    @NSManaged public var bithday: Brithday_?

}
