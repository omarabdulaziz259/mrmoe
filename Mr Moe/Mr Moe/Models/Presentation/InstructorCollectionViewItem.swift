//
//  InstructorCollectionViewItem.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 13/04/2024.
//

import UIKit

struct InstructorCollectionViewItem {
    let instructor: Instructor
    var isBooked: Bool = false
    var selectionOrder: Int?
}
