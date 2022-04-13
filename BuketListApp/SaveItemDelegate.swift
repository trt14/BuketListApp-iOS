//
//  SaveItemDelegate.swift
//  BuketListApp
//
//  Created by Tarooti on 17/05/1443 AH.
//

import Foundation

protocol saveItem : class {
    func saveButtonPressed(by controller: AddItemTableViewController,with text:String,at indexpath:NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
