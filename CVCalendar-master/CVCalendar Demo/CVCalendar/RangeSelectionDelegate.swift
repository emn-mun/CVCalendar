//
//  RangeSelectionDelegate.swift
//  CVCalendar Demo
//
//  Created by Emanuel Munteanu on 29/10/15.
//  Copyright © 2015 GameApp. All rights reserved.
//

import Foundation

@objc
public protocol RangeSelectionDelegate {
    optional func onRangeSelected(startDate: CVDate, endDate: CVDate)
}