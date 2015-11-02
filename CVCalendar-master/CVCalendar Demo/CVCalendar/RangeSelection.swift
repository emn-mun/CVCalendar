//
//  RangeSelection.swift
//  CVCalendar Demo
//
//  Created by Emanuel Munteanu on 29/10/15.
//  Copyright © 2015 GameApp. All rights reserved.
//

import Foundation

public final class RangeSelection {
    private unowned let calendarView: CalendarView
    
    public var delegate: RangeSelectionDelegate!
    var isActive = false
    var isSelected = false
    var startDate: CVDate!
    var endDate: CVDate!
    
    var monthView: CVCalendarMonthView!
    
    public init(calendarView: CalendarView) {
        self.calendarView = calendarView
    }
    
    public func onStartDateSelected(dayView: DayView) {
        startDate = dayView.date
        monthView = dayView.monthView
    }
    
    public func onEndDateSelected(dayView: DayView) {
        endDate = dayView.date
        isSelected = true
        selectInterval()
        delegate?.onRangeSelected?(startDate, endDate: endDate)
    }
    
    public func onDateDeselected() {
        isSelected = false
        deSelectInterval()
    }
    
    public func isDayAlreadyPresentedInInterval(dayView: DayView) -> Bool {
        if isSelected && dayView.date.isDateInSelectedRangeEqual(startDate, endDate: endDate) {
            return true
        }
        return false
    }
    
    private func selectInterval() {
        for weekView in monthView.weekViews {
            for dayView in weekView.dayViews {
                if dayView.date.isDateInSelectedRange(startDate, endDate: endDate) {
                    calendarView.animator.animateSelectionOnDayView(dayView)
                }
            }
        }
    }
    
    private func deSelectInterval() {
        for weekView in monthView.weekViews {
            for dayView in weekView.dayViews {
                if !dayView.date.isDateEqualTo(startDate) && !dayView.date.isDateEqualTo(endDate) {
                    calendarView.animator.animateDeselectionOnDayView(dayView)
                }
            }
        }
    }
}