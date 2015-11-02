//
//  CVCalendarDayViewControlCoordinator.swift
//  CVCalendar
//
//  Created by E. Mozharovsky on 12/27/14.
//  Copyright (c) 2014 GameApp. All rights reserved.
//

import UIKit

public final class CVCalendarDayViewControlCoordinator {
    // MARK: - Non public properties
    private var selectionSet = Set<DayView>()
    private unowned let calendarView: CalendarView
    
    // MARK: - Public properties
    public weak var selectedDayView: CVCalendarDayView?
    public var animator: CVCalendarViewAnimator! {
        get {
            return calendarView.animator
        }
    }

    // MARK: - initialization
    public init(calendarView: CalendarView) {
        self.calendarView = calendarView
    }
}

// MARK: - Animator side callback

extension CVCalendarDayViewControlCoordinator {
    public func selectionPerformedOnDayView(dayView: DayView) {
        // TODO:
    }
    
    public func deselectionPerformedOnDayView(dayView: DayView) {
        if dayView != selectedDayView {
            selectionSet.remove(dayView)
            dayView.setDeselectedWithClearing(true)
        }
    }
    
    public func dequeueDayView(dayView: DayView) {
        selectionSet.remove(dayView)
    }
    
    public func flush() {
        selectedDayView = nil
        selectionSet.removeAll()
    }
}

// MARK: - Animator reference 

private extension CVCalendarDayViewControlCoordinator {
    func presentSelectionOnDayView(dayView: DayView) {
        animator.animateSelectionOnDayView(dayView)
        //animator?.animateSelection(dayView, withControlCoordinator: self)
    }
    
    func presentDeselectionOnDayView(dayView: DayView) {
        animator.animateDeselectionOnDayView(dayView)
        //animator?.animateDeselection(dayView, withControlCoordinator: self)
    }
}

// MARK: - Coordinator's control actions

extension CVCalendarDayViewControlCoordinator {
    public func performDayViewSingleSelection(dayView: DayView) {
        selectionSet.insert(dayView)
        
        // ------- MY STUFF ------
        let dicissiveCount = calendarView.rangeSelection.isActive ? 2 : 1
        // -------          ------
        
        if selectionSet.count > dicissiveCount {
            for dayViewInQueue in selectionSet {
                if dayView != dayViewInQueue {
                    if dayView.calendarView != nil {
                        presentDeselectionOnDayView(dayViewInQueue)
                        
                        // ------- MY STUFF ------
                        calendarView.rangeSelection.onDateDeselected()
                        // -------          ------
                    }
                    
                }
            }
        }
        
        if animator != nil {
            if selectedDayView != dayView {
                if calendarView.rangeSelection.isActive && calendarView.rangeSelection.isDayAlreadyPresentedInInterval(dayView) {
                    return;
                }
                
                selectedDayView = dayView
                presentSelectionOnDayView(dayView)
                
                // ------- MY STUFF ------
                if selectionSet.count == 1 || selectionSet.count == 3 {
                    calendarView.rangeSelection.onStartDateSelected(dayView)
                } else {
                    calendarView.rangeSelection.onEndDateSelected(dayView)
                }
                // -------          ------
            }
        } 
    }
    
    public func performDayViewRangeSelection(dayView: DayView) {
        print("Day view range selection found")
    }
}