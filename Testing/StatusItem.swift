//
//  StatusItem.swift
//  Testing
//
//  Created by admin-test on 1/21/23.
//

import Cocoa

class StatusItem {
    
    private var statusItem: NSStatusItem?
    
    init() {
        makeItem()
    }
    
    public func displayMenu(_ activeMenu: NSMenu) {
        statusItem!.highlightMode = true // Highlight bodge: Stop the highlight flicker (see async call below).
        statusItem!.button?.isHighlighted = true
        statusItem!.menu = activeMenu
        statusItem!.popUpMenu(activeMenu)
        statusItem!.menu = nil // Otherwise clicks won't be processed again
    }
    
    private func makeItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem!.button?.title = "env"
        statusItem!.button?.action = #selector(delegate.statusItemClicked(sender:))
        statusItem!.button?.sendAction(on: [
            NSEvent.EventTypeMask.leftMouseUp,
            NSEvent.EventTypeMask.rightMouseUp,
            NSEvent.EventTypeMask.otherMouseUp
        ])
    }
    
    public func show() {
        /*
         * Trickier logic; if we're pre-10.12 we *should* have a nil
         * statusItem.
         */
        if #available(OSX 10.12, *) {
            guard statusItem != nil else {
                return
            }
            if statusItem!.isVisible {
                return
            }
            statusItem!.isVisible = true
        } else {
            guard statusItem == nil else {
                return
            }
            makeItem()
        }
    }
}
